<if @config.shaded_p@ ne "t">

  <table border=0 cellpadding=2 cellspacing=2 width=100%>

  <multiple name="foo">
  <tr>
  
  <if @foo.type@ eq "Folder">

      <td><a href=@foo.url@?folder_id=@foo.file_id@><img border=0 src=@foo.url@graphics/folder.gif width=15 height=13> @foo.name@</a>
      </td>
      <td><small>@foo.type@</small></td>

      <if @foo.num@ lt 1 or @foo.num@ eq 0>
        <td><small>@foo.num@ items</small></td>
      </if>
      <else>
        <td><small>@foo.num@ item</small></td>

      </else>
  </if>
  <else>

    <td><a href=@foo.url@file?file_id=@foo.file_id@><img border=0 src=@foo.url@graphics/file.gif width=15 height=13> @foo.name@</a></td>
    <td><small>File</small></td>
    <td><a href=@foo.url@/download/@foo.name@?version_id=@foo.file_live_rev@><small>\[download\]</small></a></td>

  </else>

  </tr>  
  </multiple>
  
  </table>
                
</if>


