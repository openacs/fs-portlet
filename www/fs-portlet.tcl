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
}

array set config $cf
set user_id [ad_conn user_id]
set list_of_folder_ids $config(folder_id)

set user_root_folder [dotlrn_fs::get_user_root_folder -user_id $user_id]
set user_root_folder_present_p 0
set write_p 0
set admin_p 0
set delete_p 0
set url ""
if {![empty_string_p $user_root_folder] && [lsearch -exact $list_of_folder_ids $user_root_folder] != -1} {
    set user_root_folder_present_p 1

    set write_p [permission::permission_p -object_id $user_root_folder -privilege "write"]
    set admin_p [permission::permission_p -object_id $user_root_folder -privilege "admin"]

    set delete_p $admin_p
    if {!$delete_p} {
        set delete_p [permission::permission_p -object_id $user_root_folder -privilege "delete"]
    }

    set url [portal::mapping::get_url -object_id $user_root_folder]
}

form create n_past_days_form

set options {{0 -1} {1 1} {2 2} {3 3} {7 7} {14 14} {30 30}}
element create n_past_days_form n_past_days \
    -label "" \
    -datatype text \
    -widget select \
    -options $options \
    -html {onChange document.n_past_days_form.submit()} \
    -value $n_past_days

if {[form is_valid n_past_days_form]} {
    form get_values n_past_days_form n_past_days
}

db_multirow folders select_fs_objects {}

ad_return_template 
