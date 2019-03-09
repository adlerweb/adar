    <div class="infobox">
        <div class="infobox_header">
            <img src="vendor/koala-framework/library-silkicons/key.png" alt="" /> Login Panel
        </div>
        <div class="infobox_content">
            <form method="POST" action="?m=session_login">
                <label for="user">Username:</label>
                <input type="text" name="user" />
                <br />
                <label for="pass">Password:</label>
                <input type="password" name="pass" />
                <br />
                <label for="user">Title:</label>
				<select name="my_career">
				<option value="my_options">---my title---</option>
				<option value="Student">Student</option>
				<option value="Lecture">Lecture</option>
				<option value="Moderator">Moderator</option>
				<option value="Coordinator">Coordinator</option>
				</select>
				</br>
				</br>
                <input type="submit" value="Login" class="spacer" />
                {if isset($errstr)}
                    <div class="errbox spacer"><img src="vendor/koala-framework/library-silkicons/error.png" alt="error" /> {$errstr}</div>
                {/if}
            </form>
        </div>
    </div>
