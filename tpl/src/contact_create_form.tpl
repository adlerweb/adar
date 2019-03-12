<form action="index.php" method="POST">
    <fieldset>

        <legend>Name</legend>
        <table>
            <tr><td><label for="FamilyName">Name / Firmenname:</label></td><td><input type="text" id="FamilyName" size="100%" {if $details.FamilyName !== null} value="{$details.FamilyName}"{/if} /></td><td></td></tr>
            <tr><td><label for="GivenName">Vorname / Ansprechpartner:</label></td><td><input type="text" id="GivenName"  size="100%" {if $details.GivenName !== null} value="{$details.GivenName}"{/if} /></td><td></td></tr>
            <tr><td><label for="Type">Typ:</label></td><td>
                <select name="Type">
                    <option value="u" {If $details.Type == 'u'}selected="selected"{/if}>Nicht angegeben</option>
                    <option value="m" {If $details.Type == 'm'}selected="selected"{/if}>Herr</option>
                    <option value="f" {If $details.Type == 'f'}selected="selected"{/if}>Frau</option>
                    <option value="c" {If $details.Type == 'c'}selected="selected"{/if}>Firma</option>
                </select>
            </td><td></td></tr>
        </table>
    </fieldset>

    <br />

    <fieldset>
        <legend>Adresse</legend>
        <table>
<<<<<<< HEAD
            <tr><td><label for="Street">Straße:</label></td><td><input type="text" id="Street" {if $details.Street !== null} value="{$details.Street}"{/if} /> <input type="text" id="Housenr" size="6" {if $details.Housenr !== null} value="{$details.Housenr}"{/if} /></td></tr>
            <tr><td><label for="ZIP">PLZ:</label></td><td><input type="text" id="ZIP" size="6" {if $details.ZIP !== null} value="{$details.ZIP}"{/if} /> <input type="text" id="City" {if $details.City !== null} value="{$details.City}"{/if} /></td></tr>
            <tr><td><label for="Country">Land:</label></td><td>
=======
            <tr><td><label for="Street">Street:</label></td><td><input type="text" id="Street" {if $details.Street !== null} value="{$details.Street}"{/if} /> 
			<input type="text" id="Housenr" size="6" {if $details.Housenr !== null} value="{$details.Housenr}"{/if} /></td></tr>
            <tr><td><label for="ZIP">ZIP:</label></td><td><input type="text" id="ZIP" size="6" {if $details.ZIP !== null} value="{$details.ZIP}"{/if} /> 
			<input type="text" id="City" {if $details.City !== null} value="{$details.City}"{/if} /></td></tr>
            <tr><td><label for="Country">Country:</label></td><td>
>>>>>>> c1d1b4578081235e271fe0f89d9f569f480c09aa
                <select name="Country">
                    {foreach from=$countries item=c}
                        <option value="{$c.Alpha2}" {If $lang == $c.Alpha2}selected="selected"{/if}>{$c.Name}</option>
                    {/foreach}
                </select>
            </td></tr>
        </table>
    </fieldset>

    <br />

    <fieldset>
<<<<<<< HEAD
        <legend>Kontaktdaten</legend>
=======
        <legend>Contact Details</legend>
>>>>>>> c1d1b4578081235e271fe0f89d9f569f480c09aa
        <table>
            <tr><td><label for="Phone">Telefon:</label></td><td><input type="text" id="Phone" size="100%" {if $details.Phone !== null} value="{$details.Phone}"{/if} /></td></tr>
            <tr><td><label for="Fax">Fax:</label></td><td><input type="text" id="Fax" size="100%" {if $details.Fax !== null} value="{$details.Fax}"{/if} /></td></tr>
            <tr><td><label for="Mail">Mail:</label></td><td><input type="text" id="Mail" size="100%" {if $details.Mail !== null} value="{$details.Mail}"{/if} /></td></tr>
            <tr><td><label for="URL">URL:</label></td><td><input type="text" id="URL" size="100%" {if $details.URL !== null} value="{$details.URL}"{else} value="http://"{/if} /></td></tr>
        </table>
    </fieldset>

    <br />

    <fieldset>
        <legend><label for="Notes">Notizen</label></legend>
        <div id="content_desc_l">
            <textarea id="Notes" name="Notes" rows="20" cols="80">{if $details.Notes !== null}{$details.Notes}{/if}</textarea>
        </div>
    </fieldset>

    <input type="hidden" name="m" value="contact_create" />
    <input type="hidden" name="id" value="{if $details.CID !== null}{$details.CID}{else}0{/if}" />
    <input type="submit" name="a" value="Erfassen" />
</form>
