<form action="index.php" method="POST">
    <fieldset>

        <legend>Paper Information Recording Form</legend>
        <table>
            <tr>
                <td><label for="dateUpload">Date Upload:</label></td>
                <td><input type="text" id="dateUpload" {if $details.dateUpload !== null} value="{$details.dateUpload}"{/if}  /></td>
              </tr>
              <tr>
                <td><label for="dateModerated">Date Moderated:</label></td>
                <td><input type="text" id="dateModerated" {if $details.dateModerated !== null} value="{$details.dateModerated}"{/if}  /></td>
            </tr>
            <tr>
                <td><label for="lecturerID">LecturerId:</label></td>
                <td><input type="text" id="lecturerId" {if $details.lecturerId !== null} value="{$details.lecturerId}"{/if} /></td>
                <td></td>

            </tr>
            <tr>
                <td><label for="moderatorId">ModeratorId:</label></td>
                <td><input type="text" id="moderatorId" {if $details.moderatorId !== null} value="{$details.moderatorId}"{/if} /></td>
              </tr>
              <tr>
                <td><label for="studentNumber">Student Number:</label></td>
                <td><input type="text" id="studentNumber" {if $details.studentNumber !== null} value="{$details.studentNumber}"{/if} /></td>
			</tr>
            <tr>
				<td><label for="coordinatorId">CoordinatorId:</label></td>
				<td><input type="text" id="coordinatorId" {if $details.coordinatorId !== null} value="{$details.coordinatorId}"{/if} /></td>
				<td></td>
			</tr>
        <tr>
				<td><label for="clusterId">ClusterId:</label></td>
				<td><input type="text" id="clusterId" {if $details.clusterId !== null} value="{$details.clusterId}"{/if} /></td>
      </tr>
      <tr>
				<td><label for="publishedStatus">Published Status:</label></td>
				<td><input type="text" id="publishedStatus" {if $details.publishedStatus !== null} value="{$details.publishedStatus}"{/if} /></td>
			</tr>
      <tr>
        <td><label for="abstract">Abstract:</label></td>
        <td><input type="text" id="abstract" {if $details.abstract !== null} value="{$details.abstract}"{/if} /></td>
      </tr>
        </table>
    </fieldset><br />

    <input type="hidden" name="m" value="paper_create" />
    <input type="hidden" name="id" value="{if $details.paperId !== null}{$details.paperId}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>

<a href="?m=paper_list">
<input type="submit" name="a" value="View Papers" />
</a>
