<?xml version="1.0"?>
<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->


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
