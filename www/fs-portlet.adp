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

<if @write_p@ true>
  <table width="100%">
    <tr>
      <td>
        <nobr>
          <small>[
            <a href="@url@folder-create?parent_id=@folder_id@">Create a new folder</a>
            |
            <a href="@url@file-add?folder_id=@folder_id@">Upload a file</a>
            |
            <a href="@url@simple-add?folder_id=@folder_id@">Create a URL</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>

</if>


<if @scoped_p@ eq 1>
<include src=@scope_fs_url@ folder_id=@folder_id@ viewing_user_id=@user_id@ n_past_days=@n_past_days@ fs_url="@url@">
</if>


<else>

  <table class="table-display" border="0" cellpadding="3" cellspacing="0" width="100%">
    <multiple name="folders">
       <if @folders.rownum@ odd>
          <tr class="z_dark">
       </if>
       <else>
          <tr class="z_light">
       </else>

       <if @folders.type@ eq "folder">
          <td>
          <a href="@folders.url@?folder_id=@folders.object_id@">
	  <img border="0" src="/graphics/folder.gif" height="14" width="14">
 	  </a>
          </td>
          <td>
          <a href="@folders.url@?folder_id=@folders.object_id@">@folders.name@</a>
          </td>
          <td><small>@folders.type@</small></td>
          <if @folders.content_size@ eq 0>
            <td><small>0 items</small></td>
          </if>
          <else>
            <if @folders.content_size@ gt 1>
               <td><small>@folders.content_size@ items</small></td>
            </if>
            <else>
                <td><small>@folders.content_size@ item</small></td>
            </else>
          <td>&nbsp;</td>
          </else>
        </if>
        <else>
          <if @folders.type@ eq "url">
             <td>
              <a href="@folders.url@url-goto?url_id=@folders.object_id@"><img border="0" src="/graphics/file.gif"></a>
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
              <a href="@folders.url@download/@folders.file_upload_name@?version_id=@folders.live_revision@"><img border="0" src="/graphics/file.gif"></a>
             </td>
             <td>
             <a href="@folders.url@download/@folders.file_upload_name@?version_id=@folders.live_revision@">@folders.name@</a>
             </td>
             <td><small>@folders.type@</small></td>
             <td><small>@folders.content_size@ byte<if @folders.content_size ne 1>s</if></small></td>
            <td>
            <nobr> <small>[<a href="@folders.url@file?file_id=@folders.object_id@">view details</a>]</small>
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



