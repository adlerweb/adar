<form action="index.php" method="POST">
    <fieldset>

        <legend>Objektbeschreibung</legend>
        <table>
            <tr><td><label for="ItemID">ItemID:</label></td><td>
                {if $edit}
                    <input type="text" id="id" value="{$id}" size="7" readonly="readonly" />
                {else}
                    {$ScanUserShort}_<input type="text" id="ItemID" value="{$id}" onkeyup="dynReq(this, 'v', 'ItemID');" size="4" />
                {/if}
            </td><td></td></tr>
            <tr><td><label for="Caption">Titel:</label></td><td><input type="text" id="Caption" value="{$Caption}" /></td><td></td></tr>
            <tr><td><label for="Format">Format:</label></td><td><input type="hidden" name="FormatTop" value="{$Format}"/><input type="text" id="Format" placeholder="{$Format}" onfocus="dynReq(this, 'c', 'Format', 1);" onkeyup="dynReq(this, 'c', 'Format', 1);" onblur="dynReqBlur(this);" /><div id="Format_hint" style="position: absolute; background-color: #ccc;"></div></td><td></td></tr>
            <tr><td><label for="Date">Dokumentdatum:</label></td><td><!--<input type="text" id="Date" value="{$date}" />--><script>DateInput('Date', true, 'YYYY-MM-DD', '{$date}')</script></td><td></td></tr>
            <tr><td><label for="SHA256">Intigritätstest:</label></td><td><input type="text" id="SHA256" value="{$hash}" readonly="readonly" /></td><td></td></tr>
        </table>
    </fieldset><br />

    <fieldset>
        <legend>Kontext</legend>
        <table>
            <tr><td><label for="Sender">Absender:</label></td><td><input type="text" value="{$From}" id="Sender" onfocus="dynReq(this, 'c', 'Contact', 1);" onkeyup="dynReq(this, 'c', 'Contact', 1);" onblur="dynReqBlur(this);" /><div id="Sender_hint" style="position: absolute; background-color: #ccc;"></td></tr>
            <tr><td><label for="Receiver">Empf&auml;nger:</label></td><td><input type="text" value="{$To}" id="Receiver" onfocus="dynReq(this, 'c', 'Contact', 1);" onkeyup="dynReq(this, 'c', 'Contact', 1);" onblur="dynReqBlur(this);" /><div id="Receiver_hint" style="position: absolute; background-color: #ccc;"></td></tr>
            <tr><td><label for="ScanUser">Erfasst durch:</label></td><td><input type="text" id="ScanUser" value="{$ScanUser}" readonly="readonly" /></td></tr>
            <tr><td><label for="ScanDate">Erfasst am:</label></td><td><input type="text" id="ScanDate" value="{$ScanDate}" readonly="readonly" /></td></tr>
        </table>
    </fieldset><br />
    <fieldset>
        <legend><label for="Description">Beschreibung</label></legend>
        <div id="content_desc_l">
            <textarea id="Description" name="Description" rows="20" cols="80">{$descr}</textarea><br />
            {if $edit}
                <input type="text" name="OCR" id="OCR" value="{$OCRStatus}" size="2" /><label for="OCR"> OCR/Formularerkennung durchführen - 0=Nein, 1=Anfordern, 2=Erledigt</label>
            {else}
                <input type="checkbox" name="OCR" id="OCR" checked="checked" value="1" /><label for="OCR">OCR/Formularerkennung durchführen</label>
            {/if}
        </div>
    </fieldset>
    <input type="hidden" name="m" value="{$menue}" />
    {if $edit}
        <input type="submit" name="a" value="Editieren" />
    {else}
        <input type="submit" name="a" value="Erfassen" />
    {/if}
    
</form>

