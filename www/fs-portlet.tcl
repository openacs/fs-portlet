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

# fs-portlet/www/fs-portlet.tcl

ad_page_contract {
    The display logic for the fs portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs_id $Id$
} -query {
    {n_past_days "-1"}
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
set style $config(style)

set user_root_folder [dotlrn_fs::get_user_root_folder -user_id $user_id]
set user_root_folder_present_p 0

if {![empty_string_p $user_root_folder] && [lsearch -exact $list_of_folder_ids $user_root_folder] != -1} {
    set folder_id $user_root_folder
    set user_root_folder_present_p 1
} else {
    set folder_id [lindex $list_of_folder_ids 0]
}

set url [portal::mapping::get_url -object_id $folder_id]

set write_p [permission::permission_p -object_id $folder_id -privilege "write"]
set admin_p [permission::permission_p -object_id $folder_id -privilege "admin"]

set delete_p $admin_p
if {!$delete_p} {
    set delete_p [permission::permission_p -object_id $folder_id -privilege "delete"]
}

set query "select_folder_contents"
if {![string equal $style "tree"]} {
    set query "select_folders"
}

db_multirow folders $query {}

ad_return_template 
