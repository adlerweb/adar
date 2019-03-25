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

                <td><label for="moderatorId">Moderator ID Number:</label></td>
                <td><input type="text" id="moderatorId" {if $details.moderatorId !== null} value="{$details.moderatorId}"{/if} /></td>
                <td></td>
			</tr>
			<tr>
			    <td><label for="studentNumber">Student Number:</label></td>
                <td><input type="text" id="studentNumber" {if $details.studentNumber !== null} value="{$details.studentNumber}"{/if} /></td>
				<td></td>
			</tr>
            <tr>
				<td><label for="coordinatorId">Coordinator ID Number:</label></td>
				<td><input type="text" id="coordinatorId" {if $details.coordinatorId !== null} value="{$details.coordinatorId}"{/if} /></td>
				<td></td>
			</tr>
            <tr>
				<td><label for="clusterId">cluster Number:</label></td>
				<td><input type="text" id="clusterId" {if $details.clusterId !== null} value="{$details.clusterId}"{/if} /></td>
				<td></td>
			</tr>
			<tr>
			    <td><label for="publishedStatus">publish Status:</label></td>
				<td><input type="text" id="publishedStatus" {if $details.publishedStatus !== null} value="{$details.publishedStatus}"{/if} /></td>
				<td></td>

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

