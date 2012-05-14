import itertools
from PddlState import PddlState, iterator_is_empty
from PddlStateSmlAdapter import PddlStateSmlAdapter

class blocks_world:
    def __init__(self, agent):
        if agent:
            self.state = PddlStateSmlAdapter(self, agent)
        else:
            self.state = PddlState()

        self.state.predicates['on__table'] = set()
        self.state.predicates['on'] = set()
        self.state.predicates['clear'] = set()
        self.pred_param_names = {}

        self.pred_param_names['on__table'] = ('x',)

        self.pred_param_names['on'] = ('x','y',)

        self.pred_param_names['clear'] = ('x',)


    def do_action_MoveToTable(self, args):
        try:
            _omf = args['omf']
            _lower = args['lower']
        except KeyError:
            return 'Command missing parameters'
        if not ((((_omf,) in self.state.predicates['clear']) and ((_omf,_lower,) in self.state.predicates['on']))):
            return 'Preconditions not satisfied'
        predicate_adds = []
        predicate_dels = []
        predicate_adds.append(('clear', _lower))
        predicate_adds.append(('on__table', _omf))
        predicate_dels.append(('on', _omf,_lower))
        return (predicate_adds, predicate_dels)

    def do_action_MoveToBlock1(self, args):
        try:
            _omf = args['omf']
            _lower = args['lower']
            _dest = args['dest']
        except KeyError:
            return 'Command missing parameters'
        if not ((((_omf,) in self.state.predicates['clear']) and ((_dest,) in self.state.predicates['clear']) and ((_omf,_lower,) in self.state.predicates['on']))):
            return 'Preconditions not satisfied'
        predicate_adds = []
        predicate_dels = []
        predicate_adds.append(('clear', _lower))
        predicate_adds.append(('on', _omf,_dest))
        predicate_dels.append(('clear', _dest))
        predicate_dels.append(('on', _omf,_lower))
        return (predicate_adds, predicate_dels)

    def do_action_MoveToBlock2(self, args):
        try:
            _omf = args['omf']
            _dest = args['dest']
        except KeyError:
            return 'Command missing parameters'
        if not ((((_omf,) in self.state.predicates['clear']) and ((_dest,) in self.state.predicates['clear']) and ((_omf,) in self.state.predicates['on__table']))):
            return 'Preconditions not satisfied'
        predicate_adds = []
        predicate_dels = []
        predicate_adds.append(('on', _omf,_dest))
        predicate_dels.append(('clear', _dest))
        predicate_dels.append(('on__table', _omf))
        return (predicate_adds, predicate_dels)