from shutil import copy2

from charms.reactive import when, hook

BIN=files/random
DST=/opt/random

@hook('install', 'upgrade-charm')
def install():
    copy2(BIN, DST)
