<form action="index.php" method="POST">
    <fieldset>

        <legend>UserInformation</legend>
        <table>
            <tr>
                <td><label for="Dateupload">dateUpload:</label></td>
                <td><input type="text" id="Dateupload" {if $details.dateUpload !== null} value="{$details.dateUpload}"{/if}  /></td>
                <td></td>
                <!-- <td><label for="DateModerated">DateModerated:</label></td>
                <td><input type="text" id="DateModerated" {if $details.DateModerated !== null} value="{$details.DateModerated}"{/if}  /></td> -->
            </tr>
            <tr>
                <td><label for="lecturerID">lecturerId:</label></td>
                <td><input type="text" id="lecturerId" {if $details.lecturerId !== null} value="{$details.lecturerId}"{/if} /></td>
                <td></td>

            </tr>
            <tr>
                <td><label for="moderatorId">moderatorId:</label></td>
                <td><input type="text" id="moderatorId" {if $details.moderatorId !== null} value="{$details.moderatorId}"{/if} /></td>
                <td></td>
                <td><label for="studentId">studentId:</label></td>
                <td><input type="text" id="studentId" {if $details.studentId !== null} value="{$details.studentId}"{/if} /></td>
			</tr>
            <tr>
				<td><label for="CoordinatorID">coordinatorId:</label></td>
				<td><input type="text" id="coordinatorId" {if $details.coordinatorId !== null} value="{$details.coordinatorId}"{/if} /></td>
				<td></td>
			</tr>
            <tr>
				<td><label for="clusterID">clusterId:</label></td>
				<td><input type="text" id="clusterId" {if $details.clusterId !== null} value="{$details.clusterId}"{/if} /></td>
				<td></td>
				<td><label for="publishStatus">publishStatus:</label></td>
				<td><input type="text" id="publishStatus" {if $details.publishStatus !== null} value="{$details.publishStatus}"{/if} /></td>
			</tr>

        </table>
    </fieldset><br />

    <input type="hidden" name="m" value="paper_create" />
    <input type="hidden" name="id" value="{if $details.paperId !== null}{$details.userId}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>

<a href="?m=paper_list">
<input type="submit" name="a" value="Paper List" />
</a>
