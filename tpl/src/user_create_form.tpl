
<form action="index.php" method="POST">
    <fieldset>

        <legend>UserInformation</legend>
        <table>
            <tr>
                <td><label for="Name">Name:</label></td>
                <td><input type="text" id="Name" {if $details.Name !== null} value="{$details.Name}"{/if}  /></td>
                <td></td>
                <td><label for="Surname">Surname:</label></td>
                <td><input type="text" id="Surname" {if $details.Surname !== null} value="{$details.Surname}"{/if}  /></td>
            </tr>
            <tr>
                <td><label for="Username">Username:</label></td>
                <td><input type="text" id="Username" {if $details.Username !== null} value="{$details.Username}"{/if} /></td>
                <td></td>
                
            </tr>
            <tr>
                <td><label for="Password">Password:</label></td>
                <td><input type="password" id="Password" {if $details.Password !== null} value="{$details.Password}"{/if} /></td>
                <td></td>
                <!-- <td><label for="ConfirmPassword">ConfirmPassword:</label></td>
                <td><input type="password" id="ConfirmPassword" {if $details.ConfirmPassword !== null} value="{$details.ConfirmPassword}"{/if} /></td> -->
			</tr>
            <tr>
				<td><label for="EMail">EMail:</label></td>
				<td><input type="text" id="EMail" {if $details.EMail !== null} value="{$details.EMail}"{/if} /></td>
				<td></td>
			</tr>
            <tr>
				<td><label for="Level">Level:</label></td>
				<td>
				<select id="Level" name="Level">
                	{foreach from=$roles item=c}
                        <option value="{$c.roleID}" {If $lang == $c.roleID}selected="selected"{/if}>{$c.roleName}</option>
                    {/foreach}
                    <!-- <option value="0" {If $details.Level == '0'}selected="selected"{/if}>Not specified</option>
                    <option value="1" {If $details.Level == '1'}selected="selected"{/if}>Administrator</option>
                    <option value="2" {If $details.Level == '2'}selected="selected"{/if}>Moderator</option>
                    <option value="3" {If $details.Level == '3'}selected="selected"{/if}>Supervisor</option>
                    <option value="4" {If $details.Level == '4'}selected="selected"{/if}>Coordinator</option>
                    <option value="5" {If $details.Level == '5'}selected="selected"{/if}>Student</option> -->
                </select>
				</td>
				<td></td>
				<td><label for="UIdent">UIdent:</label></td>
				<td><input type="text" id="UIdent" {if $details.UIdent !== null} value="{$details.UIdent}"{/if} /></td>
			</tr>

        </table>
    </fieldset><br />

    <input type="hidden" name="m" value="user_create" />
    <input type="hidden" name="id" value="{if $details.UserID !== null}{$details.UserID}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>

