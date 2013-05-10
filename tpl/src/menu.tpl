    <div id="menu">
        {if $loginlevel >= 2}
            <div class="menu_head">▸ Recherche</div>
            <div class="menu_item {if $menue=='content_list'}menu_item_selected{/if}"><a href="?m=content_list"><img src="vendor/koala-framework/library-silkicons/table.png" /> Alle Einträge</a></div>
            <div class="menu_head">▸ Erfassen</div>
            <div class="menu_item {if $menue=='content_create'}menu_item_selected{/if}"><a href="?m=content_create"><img src="vendor/koala-framework/library-silkicons/page_add.png" /> Neuer Datensatz</a></div>
    	    <div class="menu_head">▸ Kontakte</div>
            <div class="menu_item {if $menue=='contact_create'}menu_item_selected{/if}"><a href="?m=contact_create"><img src="vendor/koala-framework/library-silkicons/user_add.png" /> Neuer Kontakt</a></div>
    	{/if}
        <div class="menu_head">▸ Verwaltung</div>
        {if $loginlevel <1}
        	<div class="menu_item {if $menue=='session_login'}menu_item_selected{/if}"><a href="?m=session_login"><img src="vendor/koala-framework/library-silkicons/key.png" /> Anmelden</a></div>
	    {/if}
    	{if $loginlevel >= 1}
            <div class="menu_item {if $menue=='session_logout'}menu_item_selected{/if}"><a href="?m=session_logout"><img src="vendor/koala-framework/library-silkicons/lock_break.png" /> Abmelden</a></div>
    	{/if}
    	{if $loginlevel >= 192}
            <div class="menu_item"><a href="#"><img src="vendor/koala-framework/library-silkicons/user.png" /> Benutzerverwaltung</a></div>
            <div class="menu_item"><a href="#" onclick="init();"><img src="vendor/koala-framework/library-silkicons/wrench.png" /> Systemparameter</a></div>
    	{/if}
    </div>
