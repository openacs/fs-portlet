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

# fs-portlet/www/fs-portlet.tcl

ad_page_contract {
    The display logic for the fs portlet

    @author yon (yon@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @cvs_id $Id$
} -query {
    {n_past_days "99999"}
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
set scoped_p [ad_decode $config(scoped_p) t 1 0]

set user_root_folder [dotlrn_fs::get_user_root_folder -user_id $user_id]
set user_root_folder_present_p 0

if {![empty_string_p $user_root_folder] && [lsearch -exact $list_of_folder_ids $user_root_folder] != -1} {
    set folder_id $user_root_folder
    set user_root_folder_present_p 1
} else {
    set folder_id [lindex $list_of_folder_ids 0]
}

set url [site_node_object_map::get_url -object_id $folder_id]
set contents_url [lindex $config(contents_url) 0]

if {[empty_string_p $contents_url]} {
    set recurse_p 1
    set contents_url "${url}folder-contents?[export_vars {folder_id recurse_p}]&"
} else {
    set contents_url "${contents_url}?"
}

set admin_p [permission::permission_p -object_id $folder_id -privilege "admin"]
set write_p $admin_p
if {!$write_p} {
    set write_p [permission::permission_p -object_id $folder_id -privilege "write"]
}
set delete_p $admin_p
if {!$delete_p} {
    set delete_p [permission::permission_p -object_id $folder_id -privilege "delete"]
}

set query "select_folders"
if {$scoped_p} {
    set scope_fs_url "/packages/file-storage/www/folder-chunk"
} else {
    db_multirow folders $query {}
}

ad_return_template 
