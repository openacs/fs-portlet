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

<if @n_folders@ eq 1 or @user_root_folder_present_p@ true>
<if @write_p@ true>
  <table>
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
    <tr>
      <td>
        <br>
        <nobr>
          <small>
            View files modified in the last
            <a href="@contents_url@n_past_days=999999">All</a>
            |
            <a href="@contents_url@n_past_days=1">1</a>
            |
            <a href="@contents_url@n_past_days=2">2</a>
            |
            <a href="@contents_url@n_past_days=3">3</a>
            |
            <a href="@contents_url@n_past_days=7">7</a>
            |
            <a href="@contents_url@n_past_days=14">14</a>
            |
            <a href="@contents_url@n_past_days=30">30</a>
            days.
          </small>
        </nobr>
      </td>
    </tr>
  </table>

  <br>
</if>
</if>

  <table border="0" cellpadding="2" cellspacing="2" width="100%">
<multiple name="folders">
    <tr>
<if @folders.type@ eq "folder">
      <td>
        <img border="0" src="@folders.url@graphics/folder.gif">
      </td>
      <td>
        <a href="@folders.url@?folder_id=@folders.object_id@">
          @folders.name@
        </a>
      </td>
      <td><small>@folders.type@</small></td>
<if @folders.content_size@ eq 0>
      <td><small>0 items</small></td>
      <td>&nbsp;</td>
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
<if @folders.type@ eq "url">
      <td>
          <img border="0" src="@folders.url@graphics/file.gif">
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
          <img border="0" src="@folders.url@graphics/file.gif">
      </td>
      <td>
        <a href="@folders.url@download/@folders.name@?version_id=@folders.live_revision@">@folders.name@</a>
      </td>
      <td><small>@folders.type@</small></td>
      <td><small>@folders.content_size@ byte<if @folders.content_size ne 1>s</if></small></td>
      <td>
        <nobr>
          <small>[
            <a href="@folders.url@file?file_id=@folders.object_id@">view details</a>
          ]</small>
        </nobr>
      </td>
</else>
</else>
    </tr>  
</multiple>
  </table>

</if>
<else>
  &nbsp;
</else>
