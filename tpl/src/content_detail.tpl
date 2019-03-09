                <div class="infobox_half_right">
                    <div class="infobox_header">
                        <div class="infobox_header_right">
                            <a href="#" onclick="lightbox_open()"><img src="vendor/koala-framework/library-silkicons/magnifier.png" alt="[Zoom]" /></a>
                            <a href="?m=content_imgwrapper&id={$ItemID}&amp;org=yes"><img src="vendor/koala-framework/library-silkicons/disk.png" alt="[Download]" /></a>
                        </div>
                        <img src="vendor/koala-framework/library-silkicons/image.png" alt="" /> Vorschau
                    </div>
                    <div class="infobox_content">
                        <nobr>
                            {if $pages == 0}
                                <img src="?m=content_imgwrapper&id={$ItemID}" alt="Preview of archived item" id="img_prev" onclick="lightbox_open()" />
                            {else}
                                <img src="?m=content_imgwrapper&id={$ItemID}&amp;page=0" alt="Preview of archived item" id="img_prev" onclick="lightbox_open()" />
                                <!--@TODO weitere Seiten-->
                            {/if}
                        </nobr>
                    </div>
                </div>
                {if $loginlevel >= 192}
                <div class="infobox_half_right">
                    <div class="infobox_header">
                        <label for="Description"><img src="vendor/koala-framework/library-silkicons/tag_blue_add.png" alt="" /> Tags</label>
                    </div>
                    <div class="infobox_content">
                        <form method="post" action="{$REQUEST_URI}">
                            <input type="hidden" name="ItemID" id="ItemID" value="{$ItemID}" />
                            <textarea name="tags" id="tags">{$Tags}</textarea>
                            <script type="text/javascript" src="lib/tagcomplete.js"></script>
                            <script>
                                {literal}
                                $( document ).ready(function() {
                                    // assign tag editor to textarea - existing text will be used as initial tags
                                    $("#tags").tagEditor({
                                        placeholder: 'Enter tags ...',
                                        removeDuplicates: true,
                                        autocomplete: {
                                            source: 'lib/liveforms.php?m=Tags&q='
                                        },
                                        beforeTagSave: tagAdd,
                                        beforeTagDelete: tagDel
                                    });
                                });
                                {/literal}
                            </script>
                        </form><br />
                    </div>
                </div>
                {/if}
                <div class="infobox_half">
                    <div class="infobox_header">
                        <img src="vendor/koala-framework/library-silkicons/book.png" alt="" /> Objektbeschreibung
                    </div>
                    <div class="infobox_content">
                        <table>
                            <tr><td>ItemID:</td><td>{$ItemID}</td></tr>
                            <tr><td>Titel:</td><td>{$Caption}</td></tr>
                            <tr><td>Seiten:</td><td>{if $pages}{$pages}{else}1{/if}</td></tr>
                            <tr><td>Format:</td><td>{$Format}</td></tr>
                            <tr><td>Inhaltsdatum:</td><td>{$Date}</td></tr>
                            <tr><td>Intigritätstest:</td><td>{$SourceSHA256}</td></tr>
                        </table>
                    </div>
                </div>
                <div class="infobox_half">
                    <div class="infobox_header">
                        <img src="vendor/koala-framework/library-silkicons/book_open.png" alt="" /> Kontext
                    </div>
                    <div class="infobox_content">
                        <table>
                            <tr><td>Absender:</td><td><a href="?m=contact_create&amp;id={$S_CID}">{$S_FamilyName}, {$S_GivenName}</a></td></tr>
                            <tr><td>Empfänger:</td><td><a href="?m=contact_create&amp;id={$R_CID}">{$R_FamilyName}, {$R_GivenName}</a></td></tr>
                            <tr><td>Erfasst durch:</td><td>{$ScanUser}</td></tr>
                            <tr><td>Erfasst am:</td><td>{$ScanDate}</td></tr>
                        </table>
                    </div>
                </div>
                <div class="infobox_full">
                    <div class="infobox_header">
                        <img src="vendor/koala-framework/library-silkicons/note.png" alt="" /> Beschreibung
                    </div>
                    <div class="infobox_content">
                        <pre>{$Description}</pre>
                    </div>
                </div>

                <!-- ZOOM -->
                <div id="lightbox">
                    <div id="lightbox_shadow">
                    </div>
                    <div id="lightbox_content">
                        <div id="lightbox_close"><a href="#" onclick="lightbox_close();"><img src="vendor/koala-framework/library-silkicons/cross.png" alt="[X]" /></a></div>
                        {if $pages == 0}
                            <img id="lightbox_image" src="?m=content_imgwrapper&amp;id={$ItemID}" alt="Zoom of archived item" onclick="lightbox_close();" />
                        {else}
                            <img id="lightbox_image" src="?m=content_imgwrapper&amp;id={$ItemID}&amp;page=0" alt="Zoom of archived item" onclick="lightbox_close();" /><br />
                            {for $i=0; $i<$pages; $i++}
                                <a href="#" onclick="lightbox_change('{$i}');">{($i+1)}</a> ·
                            {/for}
                            <a href="#" onclick="lightbox_close();">EXIT</a>

                            <script>
                                document.onkeydown = checkKey;
                                var page = 0;
                                var pagemax = {$pages};

                                function lightbox_change(newpage) {
                                    page = newpage;
                                    document.getElementById('lightbox_image').src='?m=content_imgwrapper&id={$ItemID}&page='+newpage;
                                }

                                function checkKey(e) {
                                    e = e || window.event;

                                    if (e.keyCode == '37') {
                                       // left arrow
                                       if((page-1) >= 0) {
                                           lightbox_change(page-1);
                                       }
                                    } else if (e.keyCode == '39') {
                                       // right arrow
                                       if((page+1) < pagemax) {
                                           lightbox_change(page+1);
                                       }
                                    } else if (e.keyCode == '27') {
                                       // escape
                                       lightbox_close();
                                    }
                                }
                            </script>
                        {/if}
                    </div>
                </div>
