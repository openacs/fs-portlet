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

ad_library {

    Procedures to support the file-storage portlet

    Copyright Openforce, Inc.
    Licensed under GNU GPL v2

    @creation-date September 30 2001
    @author arjun@openforce.net
    @version $Id$

}

namespace eval fs_portlet {

    ad_proc -private my_package_key {
    } {
        return "fs-portlet"
    }

    ad_proc -private get_my_name {
    } {
        return "fs_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
        return [oacs_util::parameter \
                -key "pretty_name" \
                -package_key [my_package_key]
        ]
    }

    ad_proc -public link {
    } {
        return ""
    }

    ad_proc -public add_self_to_page {
        {-page_id ""}
        {-extra_params ""}
        {-force_region ""}
        portal_id
        instance_id
        folder_id
    } {
        Adds a fs PE to the given page. If there's already and fs pe,
        it appends the values to the pe's params.

        @param portal_id The page to add self to
        @param folder_id The folder to show
        @return element_id The new element's id
    } {
        if {[empty_string_p $extra_params]} {
            set extra_params [list]
        }

        lappend extra_params [list "package_id" $instance_id]

        return [portal::add_element_or_append_id \
            -portal_id $portal_id \
            -page_id $page_id \
            -pretty_name [get_pretty_name] \
            -portlet_name [get_my_name] \
	    -force_region $force_region \
            -value_id $folder_id \
            -key folder_id \
            -extra_params [eval concat $extra_params]
        ]
    }

    ad_proc -public remove_self_from_page {
        portal_id
        instance_id
        folder_id
    } {
          Removes a fs PE from the given page
    } {
        set extra_params [list "package_id" $instance_id]

        portal::remove_element_or_remove_id \
            -portal_id $portal_id \
            -portlet_name [get_my_name] \
            -value_id $folder_id \
            -key "folder_id" \
            -extra_params $extra_params
    }

    ad_proc -public show {
         cf
    } {
    } {
        portal::show_proc_helper \
                -package_key [my_package_key] \
                -config_list $cf
    }


}
