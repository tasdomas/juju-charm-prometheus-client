from os import path
from shutil import copy2

from charms.reactive import when, hook, set_state, remove_state
from charmhelpers.core import host
from charmhelpers.core.templating import render

SVC='random'

BIN='files/random'
DST='/opt/random'

@hook('install', 'upgrade-charm')
def install():
    if not path.exists(DST):
        copy2(BIN, DST)
    render(source='upstart',
           target='/etc/init/random.conf',
           perms=0o644,
           context={'addr': ':8080'})
    restart()

@hook('start')
def start():
    host.service_start(SVC)
    set_state('reporter.started')

@hook('stop')
def stop():
    host.service_stop(SVC)
    remove_state('reporter.started')

def restart():
    if host.service_running(SVC):
        remove_state('reporter.started')
        host.service_stop(SVC)
    host.service_start(SVC)
    set_state('reporter.started')

@when('reporter.started')
@when('prometheus.changed')
def update_prometheus_scrape_targets(prometheus):
    prometheus.configure(port='8080')

