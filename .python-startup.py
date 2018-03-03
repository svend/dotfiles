import os
import pprint
import sys


def mypprint(x):
    columns = os.get_terminal_size().columns
    pprint.pprint(x, width=columns or 80, compact=True)


sys.displayhook = mypprint
# sys.displayhook = lambda x: pprint.pprint(x, compact=True)
