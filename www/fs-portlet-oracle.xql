<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="select_files_and_folders">
    <querytext>
        select cr_items.item_id as file_id,
               cr_folders.label as name,
               0 as file_live_rev,
               'Folder' as type,
               0 as ordering_key,
               (select count(*) from cr_items i where i.parent_id = cr_items.item_id) as num
        from cr_items,
             cr_folders
        where cr_items.item_id = :my_folder_id
 	and cr_items.item_id = cr_folders.folder_id
        and 't' = acs_permission.permission_p(cr_items.item_id, :user_id, 'read')
        order by ordering_key, name
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
