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
  <if @folders:rowcount@ eq 0>
    <small>Folder is empty</small>
  </if>
  <else>

    <table border="0" cellpadding="2" cellspacing="2" width="100%">    

    <multiple name="folders">

     <tr>
     
       <if @folders.type@ eq "folder">
         <td><img border="0" src="@folders.url@graphics/folder.gif"></td>
         <td><a href="@folders.url@?folder_id=@folders.object_id@">@folders.name@</a></td>
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
         <td><small>@folders.content_size@ byte<if @folders.content_size ne 1>s</if></small></td>
         </td>
        </else>
     </else>
  
     </tr>  

  </multiple>
 
  <if @write_p@ true>
    <table border=0>
      <tr>
        <td>
          <small><a href="@url@file-add?folder_id=@folder_id@">Upload a file</a></small>
        </td>
      </tr>
      <tr>
        <td>
          <small><a href="@url@simple-add?folder_id=@folder_id@">Create a URL</a></small>
        </td>
      </tr>
    </table>
  </if>

</else>
</if>
<else>
  &nbsp;
</else>
