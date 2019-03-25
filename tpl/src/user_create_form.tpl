<form action="index.php" method="POST">
    <fieldset>

        <legend>UserInformation</legend>
        <table>
            <tr>
                <td><label for="GivenName">GivenName:</label></td>
                <td><input type="text" id="GivenName" {if $details.GivenName !== null} value="{$details.GivenName}"{/if}  /></td>
                <td></td>
                <!-- <td><label for="FamilyName">FamilyName:</label></td>
                <td><input type="text" id="FamilyName" {if $details.FamilyName !== null} value="{$details.FamilyName}"{/if}  /></td> -->
            </tr>
            <tr>
                <td><label for="Nickname">Nickname:</label></td>
                <td><input type="text" id="Nickname" {if $details.Nickname !== null} value="{$details.Nickname}"{/if} /></td>
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
				<select id="Level">
                    <option value="0" {If $details.Level == '0'}selected="selected"{/if}>Not specified</option>
                    <option value="1" {If $details.Level == '1'}selected="selected"{/if}>Administrator</option>
                    <option value="2" {If $details.Level == '2'}selected="selected"{/if}>Moderator</option>
                    <option value="3" {If $details.Level == '3'}selected="selected"{/if}>Supervisor</option>
                    <option value="4" {If $details.Level == '4'}selected="selected"{/if}>Coordinator</option>
                    <option value="5" {If $details.Level == '5'}selected="selected"{/if}>Student</option>
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

