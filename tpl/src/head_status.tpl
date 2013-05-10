    <div id="header_status">
        {if isset($user) && $user != ''}
            Angemeldet als <strong>{$user}</strong><br />
            <a href="?m=session_logout"><img src="vendor/koala-framework/library-silkicons/lock_break.png" /> Abmelden</a>
        {else}
            Angemeldet als <strong>Gast</strong><br />
            <a href="?m=session_login"><img src="vendor/koala-framework/library-silkicons/key.png" /> Anmelden</a>
        {/if}
    </div>
