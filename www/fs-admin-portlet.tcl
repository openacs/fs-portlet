#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_page_contract {

    The display logic for the bulk-mail portlet

    @author yon (yon@openforce.net)
    @creation-date 2002-05-13
    @cvs-id $Id$

} -query {
} -properties {
    user_id:onevalue
    admin_p:onevalue
    package_id:onevalue
    scoped_p:onevalue
}

array set config $cf

set return_url [ns_conn url]

set user_id [ad_conn user_id]

ad_return_template

#
# Get the file-storage instance mounted underneath our node. Note
# that, in theory, multiple instances might be mounted, but this
# portlet's logics will assume only one exist in practice.
#
set package_id [lindex [site_node::get_children \
                            -package_key "file-storage" \
                            -element object_id \
                            -node_id [ad_conn node_id]] 0]

set fs_url [export_vars -base /shared/parameters {package_id return_url}]
set show_fs_url_p [parameter::get_from_package_key -parameter ShowParametersLinkP -package_key [fs_portlet::my_package_key] -default 1]

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
