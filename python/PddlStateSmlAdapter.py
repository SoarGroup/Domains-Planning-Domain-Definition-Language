import os
from PddlState import PddlState

import Python_sml_ClientInterface as sml
from OOSML import SmlObject, SmlPredicate

DYNAMIC_PREDICATES_FILE=os.path.join(os.path.split(os.path.dirname(__file__))[0], 'dyn_preds.txt')

def dynamic_predicates(domain):
	preds = set()
	add = False
	for line in open(DYNAMIC_PREDICATES_FILE):
		if line.strip() == domain:
			add = True
		elif add:
			if len(line.strip()) == 0:
				# finished reading list
				return preds
			else:
				preds.add(line.strip())

	# for if we reach the end of file
	return preds

def init_event_handler(id, userData, agent):
	userData.init()
	
class PddlStateSmlAdapter(PddlState):
	"""Subclass of PddlState that will keep a Soar agent's input-link
	consistent with the state of the environment"""
	
	def __init__(self, problem, agent, clear_visits_on_init = True):
		PddlState.__init__(self)

		self.problem = problem
		self.agent = agent
		self.clear_visits_on_init = clear_visits_on_init
		self.dynamic_predicates = dynamic_predicates(problem.domain)
		
		self.__reinit_event_id = agent.GetKernel().RegisterForAgentEvent(sml.smlEVENT_AFTER_AGENT_REINITIALIZED, init_event_handler, self)

		# A dict from predicate names to dicts, where each value dict is a map
		# from tuples of object refs (representing the parameters of a
		# particular instance of the predicate) to	SmlPredicate references
		self.pred_map = {}

		# dict from object ID strings to their SmlObject references
		self.obj_map = {}

		self.num_updates = 0

		self.state_visits = {}

		ilink = self.agent.GetInputLink()
		self.state_wme = self.agent.CreateIdWME(ilink, 'state')
		self.entity_count_wme = self.agent.CreateIntWME(ilink, 'entity-count', 0)
		self.num_updates_wme = self.agent.CreateIntWME(ilink, 'num-updates', 0)
		self.num_visits_wme = self.agent.CreateIntWME(ilink, 'num-visits', 0)
		self.agent.Commit()

	def init(self):
		PddlState.init(self)

		self.num_updates = 0
		self.update_input_stats()
		if self.clear_visits_on_init:
			self.state_visits.clear()
		
	def destroy(self):
		self.agent.GetKernel().UnregisterForAgentEvent(self.__reinit_event_id)
		self.destroy_objs_preds()
		self.agent.DestroyWME(self.state_wme)
		self.agent.DestroyWME(self.entity_count_wme)

	def destroy_objs_preds(self):
		for name, pmap in self.pred_map.items():
			for pred in pmap.values():
				pred.destroy()
			self.pred_map[name] = {}

		for obj in self.obj_map.values():
			obj.destroy()
		self.obj_map = {}

	def add_object(self, obj_id, obj_type):
		PddlState.add_object(self, obj_id, obj_type)
		
		o = SmlObject(self.agent, obj_type, obj_id)
		self.obj_map[obj_id] = o

	def add_predicate(self, pred_name, *params):
		PddlState.add_predicate(self, pred_name, *params)
		
		param_refs = [self.obj_map[p] for p in params]
		p = SmlPredicate(self.agent, pred_name, **dict(zip(self.problem.pred_param_names[pred_name], param_refs)))
		self.pred_map.setdefault(pred_name, {})[tuple(params)] = p

	def del_predicate(self, pred_name, *params):
		PddlState.del_predicate(self, pred_name, *params)
		
		pred = self.pred_map[pred_name].pop(params, None)
		if pred: pred.destroy()

	def update_input_stats(self, update_steps = True):
		dynamic_predicate_count = sum(len(v) for k,v in self.predicates.items() if k in self.dynamic_predicates)
		total_predicate_count = sum(len(x) for x in self.predicates.values())
		object_count = len(self.types)

		if update_steps:
			sr = self.get_static()
			nv = self.state_visits.get(sr, 0)
			self.state_visits[sr] = nv + 1
		
		#self.agent.Update(self.relevant_entity_count_wme, dynamic_predicate_count + object_count)
		#self.agent.Update(self.entity_count_wme, total_predicate_count + object_count)
		self.agent.Update(self.entity_count_wme, dynamic_predicate_count)
		
		if update_steps:
			self.agent.Update(self.num_updates_wme, self.num_updates)
			self.agent.Update(self.num_visits_wme, nv + 1)
		
		self.agent.Commit()

	def from_static(self, static_rep):
		self.destroy_objs_preds()

		PddlState.from_static(self, static_rep)

