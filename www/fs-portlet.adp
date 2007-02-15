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
<include src=@scope_fs_url@ folder_id=@folder_id@ root_folder_id=@folder_id@ viewing_user_id=@user_id@ n_past_days=@n_past_days@ fs_url="@url@" page_num="@page_num@">
</if>

<else>

<if @write_p@ true>
  <table width="100%">
    <tr>
      <td>
        <nobr>
          <small>[
            <a href="@url@folder-create?parent_id=@folder_id@" title="#fs-portlet.create_new_folder#">#fs-portlet.create_new_folder#</a>
            |
            <a href="@url@file-add?folder_id=@folder_id@" title="#fs-portlet.upload_file#">#fs-portlet.upload_file#</a>
            |
            <a href="@url@simple-add?folder_id=@folder_id@" title="#fs-portlet.create_url#">#fs-portlet.create_url#</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>

</if>
  <listtemplate name="folders"></listtemplate>

</else>
</if>
<else>
<small>
    #new-portal.when_portlet_shaded#
  </small>
</else>

<p>@notification_chunk;noquote@</p>

<if @webdav_url@ not nil>
      <p>#file-storage.Folder_available_via_WebDAV_at#</p>
</if>

