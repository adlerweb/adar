    <div class="infobox">
        <div class="infobox_header">
            <img src="vendor/koala-framework/library-silkicons/key.png" alt="" /> Anmeldung
        </div>
        <div class="infobox_content">
            <form method="POST" action="?m=session_login">
                <label for="user">Username:</label>
                <input type="text" name="user" />
                <br />
                <label for="pass">Password:</label>
                <input type="password" name="pass" />
                <br />
                <input type="submit" value="Log In" class="spacer" />
                {if isset($errstr)}
                    <div class="errbox spacer"><img src="vendor/koala-framework/library-silkicons/error.png" alt="error" /> {$errstr}</div>
                {/if}
            </form>
        </div>
    </div>
