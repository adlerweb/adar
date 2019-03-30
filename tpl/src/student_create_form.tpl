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
                <td><label for="surname">Surname:</label></td>
                <td><input type="text" id="surname" {if $details.surname !== null} value="{$details.surname}"{/if} /></td>
                <td></td>
			</tr>
            <tr>
				<td><label for="gender">Gender:</label></td>
				<td><input type="text" id="gender" {if $details.gender !== null} value="{$details.gender}"{/if} /></td>
				<td></td>
			</tr>
            <tr>
				<td><label for="course">Course:</label></td>
				<td><input type="text" id="course" {if $details.course !== null} value="{$details.course}"{/if} /></td>
				<td></td>
			</tr>

        </table>
    </fieldset><br />


    <input type="hidden" name="m" value="student_create" />
    <input type="hidden" name="id" value="{if $details.studentID !== null}{$details.studentID}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>
