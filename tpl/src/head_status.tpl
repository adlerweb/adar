<<<<<<< HEAD
    <div id="header_status">
        {if isset($user) && $user != ''}
            Logged in as <strong>{$user}</strong><br />
            <a href="?m=session_logout"><img src="vendor/koala-framework/library-silkicons/lock_break.png" /> Sign out</a>
        {else}
            Logged in as <strong>Guest</strong><br />
            <a href="?m=session_login"><img src="vendor/koala-framework/library-silkicons/key.png" /> Log In</a>
        {/if}
    </div>
=======

    <div id="header_status">
        {if isset($user) && $user != ''}
            Logged in as <strong>{$user}</strong><br />
            <a href="?m=session_logout"><img src="vendor/koala-framework/library-silkicons/lock_break.png" /> Sign out</a>
        {else}
            Logged in as <strong>Guest</strong><br />
            <a href="?m=session_login"><img src="vendor/koala-framework/library-silkicons/key.png" /> Log In</a>
        {/if}
    </div>

>>>>>>> 0bf118a199690b3852a2d5a026905948aba25154
