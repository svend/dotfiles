import pprint
import sys


def _python3():
    return sys.version_info.major == 3


if _python3():
    import os

    def mypprint(x):
        columns = os.get_terminal_size().columns
        pprint.pprint(x, width=columns or 80, compact=True)

    sys.displayhook = mypprint
else:
    sys.displayhook = pprint.pprint
