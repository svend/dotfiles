import pprint
import sys

sys.displayhook = lambda x: pprint.pprint(x, compact=True)
