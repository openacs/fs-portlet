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
              <a href="@url@file-add?folder_id=@folder_id@">Upload a file</a>
              |
              <a href="@url@simple-add?folder_id=@folder_id@">Create a URL</a>
            ]</small>
          </nobr>
          <br><br>
        </td>
      </tr>
</if>
</table>
<include src=@scope_fs_url@ folder_id=@folder_id@ viewing_user_id=@user_id@ n_past_days=@n_past_days@ fs_url="@url@">