<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_files_and_folders">
        <querytext>
            select fs_objects.object_id,
                   fs_objects.name,
                   fs_objects.live_revision,
                   fs_objects.type,
                   fs_objects.content_size
            from fs_objects
            where fs_objects.object_id = :my_folder_id
            and 't' = acs_permission.permission_p(fs_objects.object_id, :user_id, 'read')
            order by fs_objects.sort_key,
                     fs_objects.name
        </querytext>
    </fullquery>

    <fullquery name="select_package_id">
        <querytext>
            select file_storage.get_package_id(:my_folder_id)
            from dual
        </querytext>
    </fullquery>

</queryset>
