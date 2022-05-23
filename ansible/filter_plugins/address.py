# -*- coding: utf-8 -*-
#
# Copyright 2019 Radosław Piliszek (yoctozepto)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from jinja2.filters import contextfilter
from jinja2.runtime import Undefined

from ansible.errors import AnsibleFilterError

def _call_bool_filter(context, value):
    """Pass a value through the 'bool' filter.

    :param context: Jinja2 Context object.
    :param value: Value to pass through bool filter.
    :returns: A boolean.
    """
    return context.environment.call_filter("bool", value, context=context)


@contextfilter
def filter_address(context, network_name, hostname=None):
    """returns IP address on the requested network

    The output is affected by '<network_name>_*' variables:
    '<network_name>_interface' sets the interface to obtain address for.
    '<network_name>_address_family' controls the address family (ipv4/ipv6).

    :param context: Jinja2 Context
    :param network_name: string denoting the name of the network to get IP
                         address for, e.g. 'api'
    :param hostname: to override host which address is retrieved for
    :returns: string with IP address
    """

    # NOTE(yoctozepto): watch out as Jinja2 'context' behaves not exactly like
    # the python 'dict' (but mimics it most of the time)
    # for example it returns a special object of type 'Undefined' instead of
    # 'None' or value specified as default for 'get' method
    # 'HostVars' shares this behavior

    if hostname is None:
        hostname = context.get('inventory_hostname')
        if isinstance(hostname, Undefined):
            raise AnsibleFilterError("'inventory_hostname' variable is unavailable")

    hostvars = context.get('hostvars')
    if isinstance(hostvars, Undefined):
        raise AnsibleFilterError("'hostvars' variable is unavailable")

    host = hostvars.get(hostname)
    if isinstance(host, Undefined):
        raise AnsibleFilterError("'{hostname}' not in 'hostvars'"
                          .format(hostname=hostname))

    del hostvars  # remove for clarity (no need for other hosts)

    # NOTE(yoctozepto): variable "host" will *not* return Undefined
    # same applies to all its children (act like plain dictionary)

    interface_name = host.get(network_name + '_interface')
    if interface_name is None:
        raise AnsibleFilterError("Interface name undefined "
                          "for network '{network_name}' "
                          "(set '{network_name}_interface')"
                          .format(network_name=network_name))

    address_family = 'ipv4'

    ansible_interface_name = interface_name.replace('-', '_')
    interface = host.get('ansible_' + ansible_interface_name)
    if interface is None:
        raise AnsibleFilterError("Interface '{interface_name}' "
                          "not present "
                          "on host '{hostname}'"
                          .format(interface_name=interface_name,
                                  hostname=hostname))

    af_interface = interface.get(address_family)
    if af_interface is None:
        raise AnsibleFilterError("Address family '{address_family}' undefined "
                          "on interface '{interface_name}' "
                          "for host: '{hostname}'"
                          .format(address_family=address_family,
                                  interface_name=interface_name,
                                  hostname=hostname))

    if address_family == 'ipv4':
        address = af_interface.get('address')

    if address is None:
        raise AnsibleFilterError("{address_family} address missing "
                          "on interface '{interface_name}' "
                          "for host '{hostname}'"
                          .format(address_family=address_family,
                                  interface_name=interface_name,
                                  hostname=hostname))
    return address


@contextfilter
def filter_interface_name(context, network_name, hostname=None):
    """returns IP address on the requested network

    The output is affected by '<network_name>_*' variables:
    '<network_name>_interface' sets the interface to obtain address for.
    '<network_name>_address_family' controls the address family (ipv4/ipv6).

    :param context: Jinja2 Context
    :param network_name: string denoting the name of the network to get IP
                         address for, e.g. 'api'
    :param hostname: to override host which address is retrieved for
    :returns: string with IP address
    """

    # NOTE(yoctozepto): watch out as Jinja2 'context' behaves not exactly like
    # the python 'dict' (but mimics it most of the time)
    # for example it returns a special object of type 'Undefined' instead of
    # 'None' or value specified as default for 'get' method
    # 'HostVars' shares this behavior

    if hostname is None:
        hostname = context.get('inventory_hostname')
        if isinstance(hostname, Undefined):
            raise AnsibleFilterError("'inventory_hostname' variable is unavailable")

    hostvars = context.get('hostvars')
    if isinstance(hostvars, Undefined):
        raise AnsibleFilterError("'hostvars' variable is unavailable")

    host = hostvars.get(hostname)
    if isinstance(host, Undefined):
        raise AnsibleFilterError("'{hostname}' not in 'hostvars'"
                          .format(hostname=hostname))

    del hostvars  # remove for clarity (no need for other hosts)

    # NOTE(yoctozepto): variable "host" will *not* return Undefined
    # same applies to all its children (act like plain dictionary)

    interface_name = host.get(network_name + '_interface')
    if interface_name is None:
        raise AnsibleFilterError("Interface name undefined "
                          "for network '{network_name}' "
                          "(set '{network_name}_interface')"
                          .format(network_name=network_name))

    ansible_interface_name = interface_name.replace('-', '_')
    interface = host.get('ansible_' + ansible_interface_name)
    if interface is None:
        raise AnsibleFilterError("Interface '{interface_name}' "
                          "not present "
                          "on host '{hostname}'"
                          .format(interface_name=interface_name,
                                  hostname=hostname))

    return interface_name

class FilterModule(object):

    def filters(self):
        return {
            'filter_interface_name': filter_interface_name,
            'filter_address': filter_address
            }