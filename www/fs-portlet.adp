<if @config.shaded_p@ ne "t">

  <table border=0 cellpadding=2 cellspacing=2 width=100%>

  <multiple name="items">
  <tr>
  
  <if @items.type@ eq "Folder">

      <td><a href=@items.name@?folder_id=@items.file_id@><img border=0 src=@items.name@graphics/folder.gif width=15 height=13> @items.name@</a>
      </td>
      <td><small>@items.type@</small></td>

      <if @items.num@ lt 1 or @items.num@ eq 0>
        <td><small>@items.num@ items</small></td>
      </if>
      <else>
        <td><small>@items.num@ item</small></td>

      </else>
  </if>
  <else>

    <td><a href=@items.name@file?file_id=@items.file_id@><img border=0 src=@items.name@graphics/file.gif width=15 height=13> @items.name@</a></td>
    <td><small>File</small></td>
    <td><a href=@items.name@/download/@items.name@?version_id=@items.file_live_rev@><small>\[download\]</small></a></td>

  </else>

  </tr>  
  </multiple>
  
  </table>
                
</if>


