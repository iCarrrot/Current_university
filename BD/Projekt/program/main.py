import sys
import json
from pprint import pprint

for line in sys.stdin:
    data = json.loads(line)
    x= data.keys()[0]
    #print x[0]
    print x
    pprint(data[x])




#print("hello world")
