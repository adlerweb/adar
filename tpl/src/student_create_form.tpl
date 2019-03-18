<form action="index.php" method="POST">
    <fieldset>

        <legend>Student Registration form</legend>
        <table>
            <tr>
                <td><label for="studentNumber">Student Numbermber:</label></td>
                <td><input type="number" id="studentNumber" {if $details.studentNumber !== null} value="{$details.studentNumber}"{/if}  /></td>
                <td></td>
            </tr>
            <tr>
                <td><label for="firstName">First Name:</label></td>
                <td><input type="text" id="firstName" {if $details.firstName !== null} value="{$details.firstName}"{/if} /></td>

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
				<td><input type="text" id="Level" {if $details.Level !== null} value="{$details.Level}"{/if} /></td>
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

