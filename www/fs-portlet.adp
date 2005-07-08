<%

    #
    #  Copyright (C) 2001, 2002 MIT
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

%>

<if @config.shaded_p@ false>

<if @scoped_p@ eq 1>
<include src=@scope_fs_url@ folder_id=@folder_id@ root_folder_id=@folder_id@ viewing_user_id=@user_id@ n_past_days=@n_past_days@ fs_url="@url@">
</if>

<else>

<if @write_p@ true>
  <table width="100%">
    <tr>
      <td>
        <nobr>
          <small>[
            <a href="@url@folder-create?parent_id=@folder_id@">#fs-portlet.create_new_folder#</a>
            |
            <a href="@url@file-add?folder_id=@folder_id@">#fs-portlet.upload_file#</a>
            |
            <a href="@url@simple-add?folder_id=@folder_id@">#fs-portlet.create_url#</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>

</if>

  <table class="table-display" border="0" cellpadding="3" cellspacing="0" width="100%">
    <multiple name="folders">
       <if @folders.rownum@ odd>
          <tr class="odd">
       </if>
       <else>
          <tr class="even">
       </else>

       <if @folders.type@ eq "folder">
          <td>
          <a href="@folders.url@?folder_id=@folders.object_id@">
	  <img border="0" src="/resources/file-storage/folder.gif" height="14" width="14">
 	  </a>
          </td>
          <td>
          <a href="@folders.url@?folder_id=@folders.object_id@">@folders.name@</a>
          </td>
          <td><small>#file-storage.folder_type_pretty_name#</small></td>
          <if @folders.content_size@ eq 0>
            <td><small>0 #fs-portlet.items#</small></td>
          </if>
          <else>
            <if @folders.content_size@ gt 1>
               <td><small>@folders.content_size@ #fs-portlet.items#</small></td>
            </if>
            <else>
                <td><small>@folders.content_size@ #fs-portlet.item#</small></td>
            </else>
          <td>&nbsp;</td>
          </else>
        </if>
        <else>
          <if @folders.type@ eq "url">
             <td>
              <a href="@folders.url@url-goto?url_id=@folders.object_id@"><img border="0" src="/resources/file-storage/file.gif"></a>
             </td>
             <td>
             <a href="@folders.url@url-goto?url_id=@folders.object_id@">@folders.name@</a>
             </td>
             <td><small>@folders.type@</small></td>
             <td><small>&nbsp;</small></td>
             <td><small>&nbsp;</small></td>
          </if>
          <else>
             <td>
              <a href="@folders.url@download/@folders.file_upload_name@?version_id=@folders.live_revision@"><img border="0" src="/resources/file-storage/file.gif"></a>
             </td>
             <td>
             <a href="@folders.url@download/@folders.file_upload_name@?version_id=@folders.live_revision@">@folders.name@</a>
             </td>
             <td><small>@folders.type@</small></td>
             <td><small>@folders.content_size@ <if @folders.content_size eq 1>#fs-portlet.byte#</if><else>#fs-portlet.bytes#</else></small></td>
            <td>
            <nobr> <small>[<a href="@folders.url@file?file_id=@folders.object_id@">#fs-portlet.view_details#</a>]</small>
            </nobr>
            </td>
         </else>
      </else>
      </tr>  
   </multiple>
   </table>

</else>

</if>
<else>
  &nbsp;
</else>

<p>@notification_chunk;noquote@</p>

<if @webdav_url@ not nil>      
      <p>#file-storage.Folder_available_via_WebDAV_at#</p>
      <p>@webdav_url@</p>
</if>

