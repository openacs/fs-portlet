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

<if @config.shaded_p@ ne "t">

<include src="@scope_fs_url;literal@" folder_id="@folder_id;literal@" root_folder_id="@root_folder_id;literal@" viewing_user_id="@user_id;literal@" n_past_days="@n_past_days;literal@" fs_url="@url;literal@">
<p>@notification_chunk;noquote@</p>
<if @webdav_url@ not nil>
      <p>#file-storage.Folder_available_via_WebDAV_at#</p>
</if>
</if>
<else>
  <small>
    #new-portal.when_portlet_shaded#
  </small>
</else>
