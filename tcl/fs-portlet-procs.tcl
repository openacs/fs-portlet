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
	folder_id 
    } {
	Adds a fs PE to the given page with the folder_id being
	opaque data in the portal configuration.
    
	@return element_id The new element's id
	@param page_id The page to add self to
	@param folder_id The folder to show
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Tell portal to add this element to the page
	set element_id [portal::add_element $page_id [my_name]]
	
	# The default param "folder_id" must be configured
	set key "folder_id"
	set value [portal::get_element_param $element_id $key]

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

	# a big-time query from file-storage
	set query \ "
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
	    append data "<tr><td>$name</td><td>$path</td><td>$content_size</td><td><td>type</td>$last_modified</td>"
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
	    set template "<i>No items in this folder</i>"
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
	# Find out the element_id that corresponds to this community_id
	# and folder_id
	
	if { [db0or1row get_element_id "
	select pem.element_id as element_id
	from portal_element_parameters pep, portal_element_map pem
	where pem.portal_id = $portal_id and
	pep.element_id = pem.element_id and
	pep.key = 'community_id' and
	pep.value = $community_id and
	pep.key = 'folder_id' and
	pep.value = $folder_id
	"]  } {
	     
	    # delete the params
	    # delete the element from the map
	    ns_log Notice "AKS54 fs-portlet-procs delete called"

	 } else {
	     ad_return_complaint 1 "fs_portlet::remove_self_from_page: Invalid portal_id and/or folder_id and/or community_id given."
	     ad_script_abort
	 }

	 # this call removes the PEs params too
	 set element_id [portal::remove_element {$portal_id $element_id}]
     }
 }

 

