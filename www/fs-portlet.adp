<if @config.shaded_p@ ne "t">
  <table border="0" cellpadding="2" cellspacing="2" width="100%">
<multiple name="folders">
    <tr>
<if @folders.type@ eq "Folder">
      <td>
        <a href="@folders.url@?folder_id=@folders.file_id@">
          <img border="0" src="@folders.url@graphics/folder.gif" width="15" height="13"></img>&nbsp;@folders.name@
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
          <img border="0" src="@folders.url@graphics/file.gif" width="15" height="13"></img>&nbsp;@folders.name@
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
