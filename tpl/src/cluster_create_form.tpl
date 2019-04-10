
<form action="index.php" method="POST">
    <fieldset>

        <legend>Cluster Information Recording Form</legend>
        <table>
            <tr>
                <td><label></label></td>
                <td></td>
            </tr>
            <tr>
                <td><label for="clustername">Cluster Name:</label></td>
                <td><input type="text" id="clustername" {if $details.clustername !== null}
                    value="{$details.clustername}"{/if}/></td>
            </tr>
            <tr>
                <td><label for="Description">Cluster Description:</label></td>
                <td><input type="text" id="Description" {if $details.Description!== null} value="{$details.Description}"{/if}/></td>
            </tr>
            <tr>
                <td><label for="lecturerID"></label></td>
                <!--td><input type="text" id="lecturerId" {if $details.lecturerId !== null} value="{$details.lecturerId}"{/if} /></td-->
                <td>

                </td>

            </tr>
            <tr>
                <td><label for="moderatorId"></label></td>
                <!--td><input type="text" id="moderatorId" {if $details.moderatorId !== null} value="{$details.moderatorId}"{/if} /></td-->
                <td>

                </td>
              </tr>
              <tr>
                <td><label></label></td>
                <td>
                </td>
			</tr>
            <tr>
				<td><label></label></td>
				<!--td><input type="text" id="coordinatorId" {if $details.coordinatorId !== null} value="{$details.coordinatorId}"{/if} /></td-->
        <td>

        </td>
			</tr>
        <tr>
				<td><label></label></td>
				<!--td><input type="text" id="clusterId" {if $details.clusterId !== null} value="{$details.clusterId}"{/if} /></td-->
        <td>

        </td>
      </tr>
        </table>
    </fieldset><br />

    <input type="hidden" name="m" value="cluster_create" />
    <input type="hidden" name="id" value="{if $details.clusterId !== null}{$details.clusterId}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>

<a href="?m=cluster_list">
<input type="submit" name="a" value="View Clusters" />
</a>
