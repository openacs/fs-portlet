<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_files_and_folders">
        <querytext>
            select fs_folders_and_files.file_id,
                   fs_folders_and_files.name,
                   fs_folders_and_files.live_revision,
                   fs_folders_and_files.type,
                   fs_folders_and_files.content_size
            from fs_folders_and_files
            where fs_folders_and_files.file_id = :my_folder_id
            and 't' = acs_permission.permission_p(fs_folders_and_files.file_id, :user_id, 'read')
            order by fs_folders_and_files.sort_key,
                     fs_folders_and_files.name
        </querytext>
    </fullquery>

    <fullquery name="select_package_id">
        <querytext>
            select file_storage.get_package_id(:my_folder_id)
            from dual
        </querytext>
    </fullquery>

</queryset>
