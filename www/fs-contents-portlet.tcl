#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
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
    The display logic for the fs contents portlet. 

    These portlets show the contents of the given folder in a table 

    re-using a lot of code from fs-portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$

} -query {
} -properties {
    user_id:onevalue
    user_root_folder:onevalue
    user_root_folder_present_p:onevalue
    write_p:onevalue
    admin_p:onevalue
    delete_p:onevalue
    url:onevalue
    folders:multirow
    n_folders:onevalue
}

array set config $cf
set user_id [ad_conn user_id]
set list_of_folder_ids $config(folder_id)
set n_folders [llength $list_of_folder_ids]

if {$n_folders != 1} {
    # something went wrong, we can't have more than one folder here
    ad_return -error
}

set folder_id [lindex $list_of_folder_ids 0]
set url [site_node_object_map::get_url -object_id $folder_id]
set recurse_p 1
set contents_url "${url}folder-contents?[export_vars {folder_id recurse_p}]&"

set admin_p [permission::permission_p -object_id $folder_id -privilege "admin"]
set write_p $admin_p
if {!$write_p} {
    set write_p [permission::permission_p -object_id $folder_id -privilege "write"]
}
set delete_p $admin_p
if {!$delete_p} {
    set delete_p [permission::permission_p -object_id $folder_id -privilege "delete"]
}

db_multirow folders select_folder_contents {}

ad_return_template 
