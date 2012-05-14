
class SmlObject:
    def __init__(self, _agent, _type, id, **kwargs):
        self.__agent = _agent
        state = self.__agent.GetInputLink().FindByAttribute('state', 0).ConvertToIdentifier()
        self.__ident = self.__agent.CreateIdWME(state, _type)
        # map from attribute name to wme
        self.__attr_wmes = {}

        self.id = id
        self.__type = _type

        for attr, val in kwargs.items():
            setattr(self, attr, val)

    def __setattr__(self, name, value):
        if name.startswith('_'):
            self.__dict__[name] = value
            return

        if name == 'id' and 'id' in self.__dict__:
                raise AttributeError("Object ids cannot be modified")

        if name in self.__attr_wmes:
            self.__agent.Update(self.__attr_wmes[name], value)
        else:
            if isinstance(value, int):
                wme = self.__agent.CreateIntWME(self.__ident, name, value)
            elif isinstance(value, float):
                wme = self.__agent.CreateFloatWME(self.__ident, name, value)
            elif isinstance(value, str):
                wme = self.__agent.CreateStringWME(self.__ident, name, value)
            else:
                raise TypeError('Value for attribute %s is not an integer, float, or string' % name)
            # should probably also consider having other objects for properties

            self.__attr_wmes[name] = wme

        self.__dict__[name] = value

    def destroy(self):
        self.__agent.DestroyWME(self.__ident)
        self.__agent.Commit()

    def gettype(self):
        return self.__type

class SmlPredicate:
    def __init__(self, _agent, _name, **kwargs):
        # map from parameter name to its wme
        self.__param_ident_map = {}

        self.__agent = _agent
        state = self.__agent.GetInputLink().FindByAttribute('state', 0).ConvertToIdentifier()
        self.__ident = self.__agent.CreateIdWME(state, _name)

        self.__name = _name

        for attr, val in kwargs.items():
            setattr(self, attr, val)

    def getname(self):
        return self.__name

    def __setattr__(self, name, value):
        if name.startswith('_'):
            self.__dict__[name] = value
            return

        if name == 'name':
            if 'name' in self.__dict__:
                raise AttributeError("Predicate names cannot be modified")
            else:
                self.__dict__['name'] = str(value)
                return

        if not isinstance(value, SmlObject):
            raise TypeError('Predicates can only have objects for parameters')

        if name in self.__param_ident_map:
            # already assigned an object, have to destroy this link
            self.__agent.DestroyWME(self.__param_ident_map[name])

        wme = self.__agent.CreateSharedIdWME(self.__ident, name, value._SmlObject__ident)
        self.__param_ident_map[name] = wme
        self.__dict__[name] = value

    def destroy(self):
        for param_wme in self.__param_ident_map.values():
            self.__agent.DestroyWME(param_wme)

        self.__agent.DestroyWME(self.__ident)
        self.__agent.Commit()
