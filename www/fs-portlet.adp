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

<if @config.shaded_p@ ne "t">
  <table border="0" cellpadding="2" cellspacing="2" width="100%">
<multiple name="folders">
    <tr>
<if @folders.type@ eq "Folder">
      <td>
        <a href="@folders.url@?folder_id=@folders.file_id@">
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
        <a href="@folders.url@file?file_id=@folders.file_id@">
          <img border="0" src="@folders.url@graphics/file.gif" width="15" height="13">&nbsp;@folders.name@
        </a>
      </td>
      <td><small>File</small></td>
      <td>
        <a href="@folders.url@/download/@folders.name@?version_id=@folders.live_revision@">
          <small>\[ download \]</small>
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
