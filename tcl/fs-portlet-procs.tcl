# fs-portlet/tcl/fs-portlet-procs.tcl

ad_library {

Procedures to support the file-storage portlet

Copyright Openforce, Inc.
Licensed under GNU GPL v2 

@creation-date September 30 2001
@author arjun@openforce.net 
@cvs-id $Id$

}

namespace eval fs_portlet {

    ad_proc -private my_name {
    } {
    return "fs_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
	return "Documents"
    }

    ad_proc -public link {
    } {
	return "file-storage"
    }

    ad_proc -public add_self_to_page { 
	portal_id 
	instance_id
	folder_id 
    } {
	Adds a fs PE to the given page with the community_id and 
	folder_id being opaque data in the portal configuration.
    
	@return element_id The new element's id
	@param portal_id The page to add self to
	@param community_id The community with the folder
	@param folder_id The folder to show
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Add some smarts to only add one portlet for now when it's
        # added multiple times (ben)
	# Find out if bboard already exists
	set element_id_list \
                [portal::get_element_ids_by_ds $portal_id [my_name]]

	if {[llength $element_id_list] == 0} {
	    # Tell portal to add this element to the page
	    set element_id [portal::add_element $portal_id [my_name]]
	    # There is already a value for the param which must be overwritten
	    portal::set_element_param $element_id instance_id $instance_id
	    portal::set_element_param $element_id folder_id $folder_id
	    set package_id_list [list]
	} else {
	    set element_id [lindex $element_id_list 0]
	    # There are existing values which should NOT be overwritten
	    portal::add_element_param_value \
                    -element_id $element_id \
                    -key instance_id \
                    -value $instance_id

	    portal::add_element_param_value \
                    -element_id $element_id \
                    -key folder_id \
                    -value $folder_id
	}
	
	return $element_id
    }

    ad_proc -public show { 
	 cf 
    } {
	 Display the PE
    
	 @return HTML string
	 @param cf A config array
	 @author arjun@openforce.net
	 @creation-date Sept 2001
    } {

	array set config $cf	

	# things we need in the config folder_id

	# get user_id from the conn at this point

	set user_id [ad_conn user_id]

	# a big-time query from file-storage
	set query "
	select i.item_id as file_id,
	r.title as name,
	i.live_revision file_live_rev,
	r.mime_type as type,
	1 as ordering_key,
        0 as num
	from   cr_items i, cr_revisions r, acs_objects o
	where  i.item_id       = o.object_id
	and    i.live_revision = r.revision_id (+)
	and    i.parent_id     = :my_folder_id
	and    acs_permission.permission_p(i.item_id, :user_id, 'read') = 't'
	and    i.content_type = 'content_revision'
	UNION
        select 
        i.item_id as file_id,
	f.label as name,
        0,
 	'Folder',
        0,
        (select count(*) from cr_items where parent_id = i.item_id) as num
 	from   cr_items i, cr_folders f
 	where  i.item_id   = f.folder_id
 	and    i.parent_id = :my_folder_id
 	and    acs_permission.permission_p(:my_folder_id, :user_id, 'read') = 't' order by ordering_key,name"

        set template "<table border=0 cellpadding=2 cellspacing=2 width=100%>"

        if { $config(shaded_p) == "f" } {

            set list_of_folder_ids $config(folder_id)

            foreach my_folder_id $list_of_folder_ids {

                set package_id [db_string get_package_id "select package_id from (select item_id from cr_items connect by prior parent_id = item_id start with item_id = :my_folder_id) this, fs_root_folders where item_id = folder_id"]

                set url [dotlrn_community::get_url_from_package_id -package_id $package_id]

                set data ""
                set rowcount 0
                
                db_foreach select_files_and_folders $query {
                                        
                    if {$type == "Folder"} {
                        append data "<tr><td><a href=${url}?folder_id=$file_id><img border=0 src=${url}graphics/folder.gif width=15 height=13> $name</a></td><td><small>$type</small></td>"
                        if { $num > 1 || $num == 0 } {
                            append data "<td><small>$num items</small></td>"
                        } else {
                            append data "<td><small>$num item</small></td>"
                        }
                    } else {
                        set type "File"
                        append data "<tr><td><a href=${url}file?file_id=$file_id><img border=0 src=${url}graphics/file.gif width=15 height=13> $name</a></td><td><small>File</small></td><td><a href=${url}/download/$name?version_id=$file_live_rev><small>\[download\]</small></a></td>"
                    }
                    append template "\n$data\n"
                }
            }
            
            append template "</table>"
            

        } else {
            # shaded	 
            set template ""
        }
                
        set code [template::adp_compile -string $template]
        
        set output [template::adp_eval code]
        return $output
    }



    ad_proc -public edit { 
    } {
	return ""
    }

    ad_proc -public remove_self_from_page { 
	portal_id 
	instance_id 
    } {
	  Removes a fs PE from the given page 
    
	  @param portal_id The page to remove self from
	  @param community_id
	  @author arjun@openforce.net
	  @creation-date Sept 2001
    } {
	# get the element IDs (could be more than one!)
	set element_ids [portal::get_element_ids_by_ds $portal_id [my_name]]

	# remove all elements
	db_transaction {
	    foreach element_id $element_ids {
		# Highly simplified (ben)
		portal::remove_element_param_value -element_id $element_id -key instance_id -value $instance_id

		# Check if we should really remove the element
		if {[llength [portal::get_element_param_list -element_id $element_id -key instance_id]] == 0} {
		    portal::remove_element $element_id
		}
	    }
	}
    }

    ad_proc -public make_self_available { 
 	portal_id 
    } {
 	Wrapper for the portal:: proc
 	
 	@param portal_id
 	@author arjun@openforce.net
 	@creation-date Nov 2001
    } {
 	portal::make_datasource_available \
 		$portal_id [portal::get_datasource_id [my_name]]
    }

    ad_proc -public make_self_unavailable { 
	portal_id 
    } {
	Wrapper for the portal:: proc
	
	@param portal_id
	@author arjun@openforce.net
	@creation-date Nov 2001
    } {
	portal::make_datasource_unavailable \
		$portal_id [portal::get_datasource_id [my_name]]
    }
}

 

