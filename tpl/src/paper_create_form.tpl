<form action="index.php" method="POST">
    <fieldset>

        <legend>UserInformation</legend>
        <table>
            <tr>
                <td><label for="Dateupload">Dateupload:</label></td>
                <td><input type="text" id="Dateupload" {if $details.Dateupload !== null} value="{$details.Dateupload}"{/if}  /></td>
                <td></td>
                <!-- <td><label for="DateModerated">DateModerated:</label></td>
                <td><input type="text" id="DateModerated" {if $details.DateModerated !== null} value="{$details.DateModerated}"{/if}  /></td> -->
            </tr>
            <tr>
                <td><label for="lecturerID">lecturerID:</label></td>
                <td><input type="text" id="lecturerID" {if $details.lecturerID !== null} value="{$details.lecturerID}"{/if} /></td>
                <td></td>
                
            </tr>
            <tr>
                <td><label for="ModeratorID">ModeratorID:</label></td>
                <td><input type="text" id="ModeratorID" {if $details.ModeratorID !== null} value="{$details.ModeratorID}"{/if} /></td>
                <td></td>
                <td><label for="StudentID">StudentID:</label></td>
                <td><input type="text" id="StudentID" {if $details.StudentID !== null} value="{$details.StudentID}"{/if} /></td>
			</tr>
            <tr>
				<td><label for="CoordinatorID">CoordinatorID:</label></td>
				<td><input type="text" id="CoordinatorID" {if $details.CoordinatorID !== null} value="{$details.CoordinatorID}"{/if} /></td>
				<td></td>
			</tr>
            <tr>
				<td><label for="clusterID">clusterID:</label></td>
				<td><input type="text" id="clusterID" {if $details.clusterID !== null} value="{$details.clusterID}"{/if} /></td>
				<td></td>
				<td><label for="publishStatus">publishStatus:</label></td>
				<td><input type="text" id="publishStatus" {if $details.publishStatus !== null} value="{$details.publishStatus}"{/if} /></td>
			</tr>

        </table>
    </fieldset><br />

    <input type="hidden" name="m" value="user_create" />
    <input type="hidden" name="id" value="{if $details.UserID !== null}{$details.UserID}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>

<a href="?m=paper_list">
<input type="submit" name="a" value="Paper List" />
</a>

