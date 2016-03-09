import sys
from subprocess import check_call


def info(msg):
    print "\033[00;34m%s\033[00m" % (msg,)

def warn(msg):
    print "\033[00;33m%s\033[00m" % (msg,)

def sh(script):
    if isinstance(script, basestring):
        return check_call(["/bin/bash", "-euo", "pipefail", "-c", script], stdout=sys.stdout, stderr=sys.stderr)
    else:
        return check_call(script, stdout=sys.stdout, stderr=sys.stderr)
