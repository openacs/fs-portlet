<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="select_files_and_folders">
<querytext>
	select 
          i.item_id as file_id,
          r.title as name,
	  i.live_revision file_live_rev,
	  r.mime_type as type,
	  1 as ordering_key,
          0 as num
	from   
          cr_items i, cr_revisions r, acs_objects o
	where  
          i.item_id       = o.object_id
	  and    i.live_revision = r.revision_id (+)
	  and    i.parent_id  in (:my_folder_id)
          and    acs_permission.permission_p(i.item_id, :user_id, 'read') = 't'
          and    i.content_type = 'content_revision'
	UNION
        select 
          i.item_id as file_id,
	  f.label as name,
          0 as file_live_rev,
 	  'Folder',
          0 as ordering_key,
          (select count(*) from cr_items where parent_id = i.item_id) as num
 	from   
          cr_items i, cr_folders f
 	where  
          i.item_id   = f.folder_id
 	  and i.parent_id in (:my_folder_id)
 	  and acs_permission.permission_p(i.item_id, :user_id, 'read') = 't'
        order by ordering_key,name
</querytext>
</fullquery>

<fullquery name="select_package_id">
<querytext>

select package_id 
from (select item_id 
      from cr_items 
      connect by prior parent_id = item_id 
      start with item_id = :my_folder_id) this, fs_root_folders 
where item_id = folder_id

</querytext>
</fullquery>

</queryset>
