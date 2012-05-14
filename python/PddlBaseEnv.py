import operator
from OOSML import SmlObject, SmlPredicate
import Python_sml_ClientInterface as sml

def iterator_is_empty(iter):
    try:
        iter.next()
    except StopIteration:
        return True
    return False

def output_event_handler(id, userData, kernel, runFlags):
    userData.update()

def init_event_handler(id, userData, agent):
    userData.init()

class PddlBaseEnv:
    def __init__(self, agent):
        self.agent = agent
        kernel = agent.GetKernel()
        self.__update_event_id = kernel.RegisterForUpdateEvent(sml.smlEVENT_AFTER_ALL_OUTPUT_PHASES, output_event_handler, self)
        self.__reinit_event_id = kernel.RegisterForAgentEvent(sml.smlEVENT_AFTER_AGENT_REINITIALIZED, init_event_handler, self)

        # A dict from predicate names to dicts, where each value dict is a map
        # from tuples of object refs (representing the parameters of a
        # particular instance of the predicate) to  SmlPredicate references
        self.predicates = {}

        # dict from object ID strings to their SmlObject references
        self.objects = {}

        # dict from object ID strings to their types
        self.types = {}

        # if we initialize from a static state representation, then we should
        # be able to reinit to it. So assign this variable to the static rep.
        self.init_state = None

        # We can't add and delete predicates immediately while handling an
        # action, since effects listed earlier could interfere with conditional
        # effects listed later. So maintain add and delete buffers
        self.predicate_add_buffer = []
        self.predicate_del_buffer = []

        self.state_wme = self.agent.CreateIdWME(self.agent.GetInputLink(), 'state')
        self.entity_count_wme = self.agent.CreateIntWME(self.agent.GetInputLink(), 'entity-count', 0)
        self.num_updates_wme = self.agent.CreateIntWME(self.agent.GetInputLink(), 'num-updates', 0)
        self.agent.Commit()

        self.num_updates = 0

    def init(self):
        if not self.init_state:
            raise NotImplementedError, "No initial state defined"

        self.num_updates = 0
        self.from_static(self.init_state)

    def destroy_objs_preds(self):
        for name, pmap in self.predicates.items():
            for pred in pmap.values():
                pred.destroy()
            self.predicates[name] = {}

        for obj in self.objects.values():
            obj.destroy()
        self.objects = {}
        self.types = {}

    def destroy(self):
        self.agent.GetKernel().UnregisterForUpdateEvent(self.__update_event_id)
        self.agent.GetKernel().UnregisterForAgentEvent(self.__reinit_event_id)
        self.destroy_objs_preds()
        self.agent.DestroyWME(self.state_wme)
        self.agent.DestroyWME(self.entity_count_wme)

    def update(self):
        for i in range(self.agent.GetNumberCommands()):
            cmd = self.agent.GetCommand(i)
            if cmd.GetParameterValue('status') == None:
                handler = getattr(self, 'handle_action_%s' % cmd.GetCommandName().strip('|'))
                if handler: 
                    err_msg = handler(cmd)
                    if err_msg:
                        self.agent.CreateStringWME(cmd, 'status', 'error')
                        self.agent.CreateStringWME(cmd, 'message', err_msg)
                    else:
                        cmd.AddStatusComplete()
        self.agent.Commit()

    def buffer_predicate_add(self, pred_name, *params):
        self.predicate_add_buffer.append((pred_name, tuple(params)))

    def buffer_predicate_delete(self, pred_name, *params):
        self.predicate_del_buffer.append((pred_name, tuple(params)))

    def do_buffered_actions(self):
        for pred_name, params in self.predicate_add_buffer:
            add_method = getattr(self, 'add_predicate_%s' % pred_name)
            if not add_method:
                raise Exception('Illegal predicate %s' % pred_name)
            add_method(*params)

        for pred_name, params in self.predicate_del_buffer:
            pred = self.predicates[pred_name].pop(params, None)

            # I used to assume that the predicate being falsified must be
            # currently true, but that doesn't seem to be the case with
            # D1S1.pddl. So if a predicate is already not true, I'm just going
            # to do nothing.
            if pred:
                pred.destroy()

        self.predicate_add_buffer = []
        self.predicate_del_buffer = []

        self.agent.Update(self.entity_count_wme, sum(len(x) for x in self.predicates.values()) + len(self.objects))
        self.num_updates += 1
        self.agent.Update(self.num_updates_wme, self.num_updates)
        self.agent.Commit()

    # Creates a static, recoverable, and comparable representation of the
    # current state, suitable for pickling.
    def get_static(self):
        # map from object refs to id strings
        obj_lookup = dict(reversed(x) for x in self.objects.items())
        
        # The predicates dict is transformed into a list of pairs 
        # (predicate name, frozensets of tuples of ID strings)
        # the list is sorted by predicate name
        predicate_table = []
        for predname in sorted(self.predicates.keys()):
            relmap = self.predicates[predname]
            true_set = frozenset(tuple(obj_lookup[y] for y in x) for x in relmap.keys())
            predicate_table.append((predname, true_set))
        
        # the type dict is changed into a list of pairs (object id, type),
        # sorted by object id
        type_table = tuple(sorted(self.types.items(), key=operator.itemgetter(0)))

        return (type_table, tuple(predicate_table))

    # Reconstruct the state from the static representation
    def from_static(self, static_rep):
        self.init_state = static_rep

        self.destroy_objs_preds()
        types_table, predicate_table = static_rep

        self.types = dict(types_table)

        for obj_id, obj_type in types_table:
            self.objects[obj_id] = SmlObject(self.agent, obj_type, obj_id)

        for predname, true_set in predicate_table:
            # These methods should be defined by the domain-specific subclass
            predicate_add_method = getattr(self, 'add_predicate_%s' % predname)
            if not predicate_add_method:
                raise Exception('Static representation contains an illegal predicate "%s"' % predname)
            args_to_rels = {}
            for s in true_set:
                obj_params = [self.objects[i] for i in s]
                predicate_add_method(*obj_params)
