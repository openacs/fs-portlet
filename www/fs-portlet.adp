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
<if @folders.num@ gt 1>
      <td><small>@folders.num@ items</small></td>
</if>
<else>
      <td><small>@folders.num@ item</small></td>
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
        <a href="@folders.url@/download/@folders.name@?version_id=@folders.file_live_rev@">
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
