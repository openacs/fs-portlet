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
    return "fs-portlet"
    }

    ad_proc -public add_self_to_page { 
	page_id 
	community_id
	folder_id 
    } {
	Adds a fs PE to the given page with the community_id and 
	folder_id being opaque data in the portal configuration.
    
	@return element_id The new element's id
	@param page_id The page to add self to
	@param community_id The community with the folder
	@param folder_id The folder to show
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Tell portal to add this element to the page
	set element_id [portal::add_element $page_id [my_name]]
	
	# The default param "community_id" must be configured
	set key "community_id"
	portal::set_element_param $element_id $key $community_id

	# The default param "folder_id" must be configured
	set key "folder_id"
	portal::set_element_param $element_id $key $folder_id

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

	# things we need in the config 
	# community_id and folder_id

	# get user_id from the conn at this point
	set user_id [ad_conn user_id]

	ns_log notice "AKS54 got here"

	# a big-time query from file-storage
	set query "
	select i.item_id as file_id,
	r.title as name,
	i.live_revision,
	content_item.get_path(i.item_id,file_storage.get_root_folder($config(community_id))) as path,
	r.mime_type as type,
	to_char(o.last_modified,'YYYY-MM-DD HH24:MI') as last_modified,
	r.content_length as content_size,
	1 as ordering_key
	from   cr_items i, cr_revisions r, acs_objects o
	where  i.item_id       = o.object_id
	and    i.live_revision = r.revision_id (+)
	and    i.parent_id     = $config(folder_id)
	and    acs_permission.permission_p(i.item_id, :user_id, 'read') = 't'
	and    i.content_type = 'content_revision'
	UNION
	select i.item_id as file_id,
	f.label as name,
	0,
	content_item.get_path(f.folder_id) as path,
	'Folder',
	NULL,
	0,
	0
	from   cr_items i, cr_folders f
	where  i.item_id   = f.folder_id
	and    i.parent_id = $config(folder_id)
	and    acs_permission.permission_p($config(folder_id), :user_id, 'read') = 't'
	order by ordering_key,name"
	
	set data ""
	set rowcount 0

	db_foreach select_files_and_folders $query {
	    append data "<tr><td>$name</td><td>$path</td><td>$content_size</td><td>type</td><td>$last_modified</td>"
	    incr rowcount
	} 

	set template "
	<table border=1 cellpadding=2 cellspacing=2>
	<tr>
	<td bgcolor=#cccccc>Name</td>
	<td bgcolor=#cccccc>Action</td>
	<td bgcolor=#cccccc>Size (bytes)</td>
	<td bgcolor=#cccccc>Type</td>
	<td bgcolor=#cccccc>Modified</td>
	</tr>
	$data
	</table>"

	ns_log notice "AKS52 got here $rowcount"

	if {!$rowcount} {
	    set template "<i>No items in this folder</i><P><a href=\"file-storage\">more...</a>"
	}

	set code [template::adp_compile -string $template]

	set output [template::adp_eval code]
	ns_log notice "AKS53 got here $output"
	
	return $output

    }

    ad_proc -public remove_self_from_page { 
	portal_id 
	community_id 
	folder_id 
    } {
	  Removes a fs PE from the given page 
    
	  @param page_id The page to remove self from
	  @param community_id
	  @param folder_id
	  @author arjun@openforce.net
	  @creation-date Sept 2001
    } {
	# get the element IDs (could be more than one!)
	set element_ids [portal::get_element_ids_by_ds $portal_id [my_name]]

	# remove all elements
	db_transaction {
	    foreach element_id $element_ids {
		portal::remove_element $element_id
	    }
	}
    }
}

 

