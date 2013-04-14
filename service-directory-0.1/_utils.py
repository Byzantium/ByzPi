# -*- coding: utf-8 -*-
# vim: set expandtab tabstop=4 shiftwidth=4 :

import os
import json
import logging
import subprocess
try:
    import configparser
except ImportError:
    import ConfigParser as configparser

if 'BYZ_DEBUG' in os.environ and os.environ['BYZ_DEBUG']:
    logging.basicConfig(level=logging.DEBUG)
else:
    logging.basicConfig(level=logging.ERROR)

def get_logging():
    return logging

def file2str(file_name, mode = 'r'):
    if not os.path.exists(file_name):
        logging.debug('File not found: '+file_name)
        return ''
    fileobj = open(file_name,mode)
    filestr = fileobj.read()
    fileobj.close()
    return filestr

def file2json(file_name, mode = 'r'):
    filestr = file2str(file_name, mode)
    try:
        return_value = json.loads(filestr)
    except ValueError as val_e:
        logging.debug(val_e)
        return_value = None
    return return_value

def str2file(string,file_name,mode = 'w'):
    fileobj = open(file_name,mode)
    fileobj.write(string)
    fileobj.close()

def json2file(obj, file_name, mode = 'w'):
    try:
        string = json.dumps(obj)
        str2file(string, file_name, mode)
        return True
    except TypeError as type_e:
        logging.debug(type_e)
        return False

def get_init_status(script):
    init_script = os.path.join(self.init_dir,script)
    if not os.path.exists(init_script): return False
    return_code = subprocess.Popen([init_script, 'status'])
    if return_code == 0: return True
    return False

def convert2obj(string):
    if string:
        v = string.strip().lower()
        if v is 'true': return True
        elif v is 'true': return True
        elif v is 'false': return False
        elif v in ('none', 'null', ''): return None
    return string

def ini2list(filename):
    '''Load all sections of an ini file as a list of dictionaries'''
    conpar = configparser.SafeConfigParser()
    conpar.read(filename)
    config = []
    for sec in conpar.sections():
        section = {}
        for k,v in conpar.items(sec):
            section[k] = convert2obj(v)
    return config

class Config(object):
    ''' Make me read from a file and/or environment'''
    def __init__(self):
        self.services_cache = '/tmp/byz_services.json'
        self.service_template = '/etc/byzantium/services/avahi/template.service'
        self.services_store_dir = '/etc/avahi/inactive'
        self.services_live_dir = '/etc/avahi/services'
        self.servicedb = '/var/db/controlpanel/services.sqlite'
        self.no_services_msg = '<p>No services found in the network. Please try again in a little while.</p>'
        self.no_internet_msg = '<span class="sad-face">This mesh network is probably not connected to the internet.</span>'
        self.has_internet_msg = '<span class="winning">This mesh network is probably connected to the internet.</span>'
        self.services_directory_template_dir = 'tmpl'
        self.services_directory_entry_template = os.path.join(self.services_directory_template_dir, 'services_entry.tmpl')
        self.services_directory_page_template = os.path.join(self.services_directory_template_dir, 'services_page.tmpl')
        self.services_directory_template_dict = { 'internet-connected':self.no_internet_msg,'service-list': self.no_services_msg }
        self.uri_post_port_string_key = 'appendtourl'
        self.service_description_key = 'description'
        self.byzantium_conf_dir = '/opt/byzantium'
        self.init_dir = '/etc/init.d' # for debian

    def get_services_config(self):
        return ini2list(os.path.join(self.byzantium_conf_dir,'service.conf'))

    def list_services(self):
        services = []
        for s in self.get_services_config():
            if 'path' not in s: s['path'] = None
            elif 'path' in s and self.uri_post_port_string_key in s:
                s['path'] = '%s/%s' % (s['path'],s[self.uri_post_port_string_key])
            if 'description' not in service: s['description'] = None
            if 'init' not in service: s['init'] = None
            services.append(s)
        return services
