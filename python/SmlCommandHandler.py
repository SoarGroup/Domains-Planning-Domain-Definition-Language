import Python_sml_ClientInterface as sml
import pdb
from time import clock
import sys

def output_handler(id, cmdhandler, agent, msg):
	t = clock()
	try:
		cmdhandler.update()
	except Exception:
		import traceback
		import sys
		traceback.print_exc(file=sys.stdout)
		pdb.set_trace()
	cmdhandler.totaltime += (clock() - t)

def halt_event_handler(id, userData, agent, phase):
	if userData.log:
		userData.log.write('---\n')
		userData.log.flush()

class SmlCommandHandler:
	def __init__(self, domain, agent, logfile=None):
		self.domain = domain
		self.agent = agent
		self.__out_event_id = agent.RegisterForRunEvent(sml.smlEVENT_AFTER_OUTPUT_PHASE, output_handler, self)
		self.__halt_event_id = agent.RegisterForRunEvent(sml.smlEVENT_AFTER_HALTED, halt_event_handler, self)
		if logfile:
			self.log = open(logfile, 'w')
		else:
			self.log = None
		
		self.totaltime = 0.0

	def unregister(self):
		self.agent.UnregisterForOutputNotification(self.__out_event_id)
		self.agent.UnregisterForRunEvent(self.__halt_event_id)
		if self.log: self.log.close()

	def change_log(self, newfile):
		if self.log: self.log.close()
		self.log = open(newfile, 'w')
		
	def update(self):
		self.agent.ClearOutputLinkChanges()
		ol = self.agent.GetOutputLink()
		if not ol:
			return
		
		for i in range(ol.GetNumberChildren()):
			cmd = ol.GetChild(i).ConvertToIdentifier()
			cmdname = cmd.GetCommandName().strip('|')
			if cmd.GetParameterValue('status') != None:
#				print 'Already processed command ^{0} {1}'.format(cmdname, cmd.GetValueAsString())
				continue
				
			args = {}
			for i in range(cmd.GetNumberChildren()):
				param = cmd.GetChild(i)
				if param.IsIdentifier():
					val_obj = param.ConvertToIdentifier().FindByAttribute('id', 0)
					if val_obj:
						args[param.GetAttribute()] = val_obj.GetValueAsString()
#					 else:
#						print "{0} doesn't have an id attrib".format(param.GetValueAsString())

			if self.log:
				self.log.write('{0} {1}\n'.format(cmdname, ' '.join('{0}:{1}'.format(a,v) for a,v in args.items())))
				self.log.flush()
				
			handler = getattr(self.domain, 'do_action_%s' % cmdname)
			if handler: 
				r = handler(args)
				
				if isinstance(r, str):
					self.agent.CreateStringWME(cmd, 'status', 'error')
					self.agent.CreateStringWME(cmd, 'message', r)
				else:
					# have to delete first, otherwise won't handle
					# the case of adding and deleting the same
					# predicate in the same turn correctly
					for p in r[1]:
						self.domain.state.del_predicate(*p)

					for p in r[0]:
						# predicates to add
						self.domain.state.add_predicate(*p)
						
					cmd.AddStatusComplete()
					self.domain.state.num_updates += 1
					self.domain.state.update_input_stats()
			else:
				self.agent.CreateStringWME(cmd, 'status', 'error')
				self.agent.CreateStringWME(cmd, 'message', 'unknown-action')
		self.agent.Commit()
