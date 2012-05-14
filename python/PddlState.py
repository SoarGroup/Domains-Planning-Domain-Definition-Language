import operator

def iterator_is_empty(iter):
    try:
        iter.next()
    except StopIteration:
        return True
    return False

class PddlState:
    def __init__(self):

        # a mapping from predicate names to sets of tuples that the
        # predicate currently holds for
        self.predicates = {}

        # dict from object ID strings to their types
        self.types = {}

        # if we initialize from a static state representation, then we should
        # be able to reinit to it. So assign this variable to the static rep.
        self.init_state = None


    def init(self):
        if not self.init_state:
            raise NotImplementedError, "No initial state defined"

        self.from_static(self.init_state)

    def add_object(self, obj_id, obj_type):
        self.types[obj_id] = obj_type

    def add_predicate(self, pred_name, *params):
        self.predicates.setdefault(pred_name, set()).add(tuple(params))

    def del_predicate(self, pred_name, *params):
        self.predicates[pred_name].discard(tuple(params))

    # Creates a static, recoverable, and comparable representation of the
    # current state, suitable for pickling.
    def get_static(self):
        # The predicates dict is transformed into a list of pairs 
        # (predicate name, frozensets of tuples of ID strings)
        # the list is sorted by predicate name
        predicate_table = [ (n, frozenset(self.predicates[n])) for n in sorted(self.predicates.keys()) ]
        
        # the type dict is changed into a list of pairs (object id, type),
        # sorted by object id
        type_table = tuple(sorted(self.types.items(), key=operator.itemgetter(0)))

        return (type_table, tuple(predicate_table))

    # Reconstruct the state from the static representation
    def from_static(self, static_rep):
        self.init_state = static_rep
        types_table, predicate_table = static_rep
        self.types = {}
        for v in self.predicates.values():
            v.clear()

        for obj_id, obj_type in types_table:
            self.add_object(obj_id, obj_type)

        for predname, true_set in predicate_table:
            for t in true_set:
                self.add_predicate(predname, *t)
