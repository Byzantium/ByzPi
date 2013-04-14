#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim: set expandtab tabstop=4 shiftwidth=4 :

'''
services.py
A module that reads the database of services running on the node and those found via avahi (mdns) and spits them out for use elsewhere.
'''

__author__ = 'haxwithaxe (me at haxwithaxe dot net)'

import _utils
import os
import re

# grab shared config
conf = _utils.Config()
logging = _utils.get_logging()

def service_states():
    services = conf.list_services()
    for s in services:
        if not s['state']:
            if not s['init']:
                s['state'] = False
            s['state'] = ask_init(s['name'])
    return services

def get_local_services_list():
    '''Get the list of services running on this node from the databases.'''
    # Pull a list of running web apps on the node.
    service_list = service_states()
    for s in service_list:
        if not s['path']:
            s['path'] = '/%s/' % s['name']
    return service_list

def get_remote_services_list():
    '''Get list of services advertised by Byzantium nodes found by avahi.'''
    service_list = []
    if not os.path.exists(conf.services_cache): return service_list
    srvcdict = file2json(conf.services_cache)
    if not srvcdict: return service_list
    for name, vals in srvcdict.items():
        if re.search('\.__byz__\._[tucdp]{3}',name):
            description = ''
            path = vals['host']
            if vals['port']: path += str(vals['port'])
            if vals['text'] not in ('','\x00'):
                for entry in vals['text'].split('\n'):
                    key,val = (entry+'=').split('=')
                    v = list(val)
                    v.pop(-1)
                    val = ''.join(v)
                    if key == conf.uri_post_port_string_key:
                        path += val
                    elif key == conf.service_description_key:
                        description += val
            name = re.sub('\.__byz__\._[udtcp]{3}.*','',name)
            service_list = [{'name':name,'path':path,'description':description}]
    return service_list

def get_services_list():
    local_srvc = get_local_services_list()
    remote_srvc = get_remote_services_list()
    return local_srvc + remote_srvc

if __name__ == '__main__':
    logging.debug(get_services_list())
