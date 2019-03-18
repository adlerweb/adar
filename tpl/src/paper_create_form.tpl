<form action="index.php" method="POST">
    <fieldset>

        <legend><b>UserInformation</b></legend>
        <table>
            <tr>
                <td><label for="dateUpload">Date Upload:</label></td>
                <td><input type="text" id="dateUpload" {if $details.dateUpload !== null} value="{$details.dateUpload}"{/if}  /></td>
                <td></td>
                <!-- <td><label for="dateModerated">Date Moderated:</label></td>
                <td><input type="text" id="dateModerated" {if $details.dateModerated !== null} value="{$details.dateModerated}"{/if}  /></td> -->
            </tr>
            <tr>
                <td><label for="lecturerId">lecturer ID Number:</label></td>
                <td><input type="text" id="lecturerId" {if $details.lecturerId !== null} value="{$details.lecturerId}"{/if} /></td>
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

    <input type="hidden" name="m" value="paper_create" />
    <input type="hidden" name="id" value="{if $details.paperId !== null}{$details.paperId}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>

<a href="?m=paper_list">
<input type="submit" name="a" value="Paper List" />
</a>

