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

    <table border="0" cellpadding="2" cellspacing="2" width="100%">

<if @write_p@ true>
      <tr>
        <td colspan="4">
          <nobr>
            <small>[
              <a href="@url@file-add?folder_id=@folder_id@">#fs-portlet.upload_file#</a>
              |
              <a href="@url@simple-add?folder_id=@folder_id@">#fs-portlet.create_url#</a>
            ]</small>
          </nobr>
          <br><br>
        </td>
      </tr>
</if>

<multiple name="folders">

      <tr>

<if @folders.type@ eq "folder">
        <td><img border="0" src="@folders.url@graphics/folder.gif"></td>
        <td><a href="@folders.url@?folder_id=@folders.object_id@">@folders.name@</a></td>
        <td><small>@folders.type@</small></td>
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
</else>
</if>
<else>
<if @folders.type@ eq "url">
        <td><img border="0" src="@folders.url@graphics/file.gif"></td>
        <td><a href="@folders.url@url-goto?url_id=@folders.object_id@">@folders.name@</a></td>
        <td><small>@folders.type@</small></td>
        <td>&nbsp;</td>
</if>
<else>
        <td><img border="0" src="@folders.url@graphics/file.gif"></td>
        <td><a href="@folders.url@download/@folders.name@?version_id=@folders.live_revision@">@folders.name@</a></td>
        <td><small>@folders.type@</small></td>
        <td><small>@folders.content_size@ <if @folders.content_size@ eq 1>#fs-portlet.byte#</if><else>#fs-portlet.bytes#</else></small></td>
</else>
</else>

      </tr>

</multiple>

    </table>

