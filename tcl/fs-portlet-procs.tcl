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

# fs-portlet/tcl/fs-portlet-procs.tcl

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

    ad_proc -private my_name {
    } {
        return "fs_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
        return [ad_parameter \
                -package_id [apm_package_id_from_key [my_package_key]] \
                "pretty_name"]
    }

    ad_proc -public link {
    } {
        return "file-storage"
    }

    ad_proc -public add_self_to_page {
        {-page_id ""}
        portal_id
        instance_id
        folder_id
        {-extra_params ""}
    } {
        Adds a fs PE to the given page. If there's already and fs pe,
        it appends the values to the pe's params.

        @param portal_id The page to add self to
        @param folder_id The folder to show

        @return element_id The new element's id

        @author arjun@openforce.net
        @creation-date Sept 2001
    } {
        if {[empty_string_p $extra_params]} {
            set extra_params [list]
        }

        lappend extra_params [list "package_id" $instance_id]

        return [portal::add_element_or_append_id \
            -portal_id $portal_id \
            -page_id $page_id \
            -pretty_name [get_pretty_name] \
            -portlet_name [my_name] \
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

          @param portal_id The page to remove self from
          @author arjun@openforce.net
          @creation-date Sept 2001
    } {
        set extra_params [list "package_id" $instance_id]

        portal::remove_element_or_remove_id \
            -portal_id $portal_id \
            -portlet_name [my_name] \
            -value_id $folder_id \
            -key "folder_id" \
            -extra_params $extra_params
    }

    ad_proc -public make_self_available {
         portal_id
    } {
         Wrapper for the portal:: proc
         
         @param portal_id
         @author arjun@openforce.net
         @creation-date Nov 2001
    } {
         portal::make_datasource_available $portal_id [portal::get_datasource_id [my_name]]
    }

    ad_proc -public make_self_unavailable {
        portal_id
    } {
        Wrapper for the portal:: proc
        
        @param portal_id
        @author arjun@openforce.net
        @creation-date Nov 2001
    } {
        portal::make_datasource_unavailable $portal_id [portal::get_datasource_id [my_name]]
    }

    ad_proc -public show {
         cf
    } {
         Display the PE

         @return HTML string
         @param cf A config array as a list
         @author arjun@openforce.net
         @creation-date Sept 2001
    } {
        # no return call required with the helper proc
        portal::show_proc_helper \
                -package_key [my_package_key] \
                -config_list $cf
    }

    ad_proc -public edit {
    } {
        return ""
    }

}
