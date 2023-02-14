
##approach--------1

x={"a":{"b":{"c":"d"}}}
for x1,y1 in x.items():
    for x2,y2 in y1.items():
        for x3,y3 in y2.items():
            print(y3)


##approach--------2

def getKey(obj: dict):
    keys = list(obj)
    if len(keys) != 1:
        raise Exception('either multiple keys or empty dict found')
    else:
        return keys[0]


def getNestedValue(obj: dict, key: str, isFound = False):
    # print(obj, key, isFound)
    if type(obj) is not dict and not isFound:
        return None
    if (isFound or (key in obj.keys())) :
        if type(obj[key]) is dict:
            return getNestedValue(obj[key], getKey(obj[key]), True)
        else:
            # print(f'obj[getKey(obj)]: {obj[getKey(obj)]}')
            return obj[getKey(obj)]
    else:
        nestedKey = getKey(obj)
        return getNestedValue(obj[nestedKey], key, False)

if _name_ == '_main_':
    obj = {'a': {'b': {'c': 'd'}}}
    value = getNestedValue(obj, 'c')
    print(value)