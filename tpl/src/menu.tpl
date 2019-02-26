    <div id="menu">
        {if $loginlevel >= 2}
            <div class="menu_head">▸ Investigation</div>
            <div class="menu_item {if $menue=='content_list'}menu_item_selected{/if}"><a href="?m=content_list"><img src="vendor/koala-framework/library-silkicons/table.png" /> All Entries</a></div>
            <div class="menu_head">▸ To capture</div>
            <div class="menu_item {if $menue=='content_create'}menu_item_selected{/if}"><a href="?m=content_create"><img src="vendor/koala-framework/library-silkicons/page_add.png" /> New Data Set</a></div>
    	    <div class="menu_head">▸ Contacts</div>
            <div class="menu_item {if $menue=='contact_create'}menu_item_selected{/if}"><a href="?m=contact_create"><img src="vendor/koala-framework/library-silkicons/user_add.png" /> New contact</a></div>
    	{/if}
        <div class="menu_head">▸ Administration</div>
        {if $loginlevel <1}
        	<div class="menu_item {if $menue=='session_login'}menu_item_selected{/if}"><a href="?m=session_login"><img src="vendor/koala-framework/library-silkicons/key.png" /> Log In</a></div>
	    {/if}
    	{if $loginlevel >= 1}
            <div class="menu_item {if $menue=='session_logout'}menu_item_selected{/if}"><a href="?m=session_logout"><img src="vendor/koala-framework/library-silkicons/lock_break.png" /> Sign out</a></div>
    	{/if}
    	{if $loginlevel >= 192}
            <div class="menu_item"><a href="#"><img src="vendor/koala-framework/library-silkicons/user.png" /> User Management</a></div>
            <div class="menu_item"><a href="#" onclick="init();"><img src="vendor/koala-framework/library-silkicons/wrench.png" /> System Parameters</a></div>
    	{/if}
    </div>
