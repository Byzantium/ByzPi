#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim: set expandtab tabstop=4 shiftwidth=4 :

import _services
import _utils

conf = _utils.Config()

def has_internet():
    '''
    determine whether there is an internet connection available with a reasonable amount of certainty.
    return bool True if there is an internet connection False if not
    '''
    # insert magic to determine if there is an internet gateway here
    return False

def main():
    service_entry = _utils.file2str(conf.services_directory_entry_template)
    page = _utils.file2str(conf.services_directory_page_template)
    services_list = _services.get_services_list()
    vals = conf.services_directory_template_dict.copy()
    if services_list and len(services_list) < 0:
        services_html = ''
        for entry in services_list:
            services_html += service_entry % entry
        vals['service-list'] = services_html
    page = page % vals
    return page

if __name__ == '__main__':
    print('Content-type: text/html\n\n')
    print(main())
