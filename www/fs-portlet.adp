<%

    #
    #  Copyright (C) 2001, 2002 OpenForce, Inc.
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

<if @user_root_folder_present_p@ true>
  <table>
<if @write_p@ true>
    <tr>
      <td width="5%"><li></td>
      <td>
        <a href="@url@file-add?folder_id=@user_root_folder@">
          Upload a file to my personal folder
        </a>
        &nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="@url@simple-add?folder_id=@user_root_folder@">
          Create a URL in my personal folder
        </a>
    </tr>
    <tr>
      <td><li></td>
      <td>
        <a href="@url@folder-create?parent_id=@user_root_folder@">
          Create a new folder within my personal folder
        </a>
      </td>
    </tr>
</if>
<if @admin_p@ true>
    <tr><td colspan="2"><br></td></tr>
    <tr>
      <td><li></td>
      <td>
        <a href="/permissions/one?object_id=@user_root_folder@">
          Modify permissions on your personal folder
        </a>
      </td>
    </tr>
</if>
    <tr><td colspan="2"><br></td></tr>
  </table>
</if>

  <table border="0" cellpadding="2" cellspacing="2" width="100%">
<multiple name="folders">
    <tr>
<if @folders.type@ eq "Folder">
      <td>
        <a href="@folders.url@?folder_id=@folders.object_id@">
          <img border="0" src="@folders.url@graphics/folder.gif" width="15" height="13">&nbsp;@folders.name@
        </a>
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
</else>
</if>
<else>
      <td>
        <a href="@folders.url@/download/@folders.name@?version_id=@folders.live_revision@">
          <img border="0" src="@folders.url@graphics/file.gif" width="15" height="13">&nbsp;
          @folders.name@
        </a>
      </td>
      <td><small>File</small></td>
      <td>
        <a href="@folders.url@file?file_id=@folders.object_id@">
          <small>[&nbsp;
            view details
          &nbsp;]</small>
        </a>
      </td>
</else>
    </tr>  
</multiple>
  </table>

</if>
<else>
  &nbsp;
</else>
