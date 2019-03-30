    <div class="infobox">
        <div class="infobox_header">
            {if isset($errico)}
                <img src="vendor/koala-framework/library-silkicons/{$errico}.png" alt="{$errico}" />
            {else}
                <img src="vendor/koala-framework/library-silkicons/exclamation.png" alt="exclamation" />
            {/if} {$titel}
        </div>
        <div class="infobox_content">
            {$errstr}
        </div>
    </div>
