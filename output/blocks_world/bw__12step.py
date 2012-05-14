from blocks_world import blocks_world

class bw__12step(blocks_world):

    domain = 'blocks_world'

    def __init__(self, agent = None):
        blocks_world.__init__(self, agent)
        self.init()

    def init(self):
        self.state.add_object('A', 'object')
        self.state.add_object('B', 'object')
        self.state.add_object('C', 'object')
        self.state.add_object('D', 'object')
        self.state.add_object('E', 'object')
        self.state.add_object('F', 'object')
        self.state.add_object('G', 'object')
        self.state.add_predicate('on__table', 'A')
        self.state.add_predicate('clear', 'A')
        self.state.add_predicate('on__table', 'B')
        self.state.add_predicate('clear', 'B')
        self.state.add_predicate('on__table', 'G')
        self.state.add_predicate('on', 'F','G')
        self.state.add_predicate('on', 'E','F')
        self.state.add_predicate('on', 'D','E')
        self.state.add_predicate('on', 'C','D')
        self.state.add_predicate('clear', 'C')

        self.state.init_state = self.state.get_static()
        self.state.update_input_stats()

problem = bw__12step