<?PHP

/**
 * AdAr - Another dumb Archive
 *
 * @package adar
 * @author Florian "adlerweb" Knodt <adar@adlerweb.info>
 */

function infomail($subject, $content) {
    if(defined('ADAR_INFOMAIL_TO') && ADAR_INFOMAIL_TO !== false && ADAR_INFOMAIL_TO != '')
        mail(ADAR_INFOMAIL_TO, $subject, $content, 'From: '.ADAR_INFOMAIL_FROM);
}

class adlerweb_smarty_adar extends adlerweb_smarty {
    function __construct($prefix = 'tpl') {
        parent::__construct($prefix);
        $this->s->assign('ADAR_PROGNAME', ADAR_PROGNAME);
    }
}

if(!defined('AW_SMARTY_ADAR_NOAUTO')) {
    $GLOBALS['adlerweb']['tpl_wrapper'] = new adlerweb_smarty_adar();
    $GLOBALS['adlerweb']['tpl'] = $GLOBALS['adlerweb']['tpl_wrapper']->s;
}

// Browsersprache ermitteln
// Quelle: http://aktuell.de.selfhtml.org/artikel/php/httpsprache/
function lang_getfrombrowser ($allowed_languages, $default_language, $lang_variable = null, $strict_mode = true) {
        // $_SERVER['HTTP_ACCEPT_LANGUAGE'] verwenden, wenn keine Sprachvariable mitgegeben wurde
        if ($lang_variable === null) {
               $lang_variable = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
        }

        // wurde irgendwelche Information mitgeschickt?
        if (empty($lang_variable)) {
                // Nein? => Standardsprache zur�ckgeben
                return $default_language;
         }

        // Den Header auftrennen
        $accepted_languages = preg_split('/,\s*/', $lang_variable);

        // Die Standardwerte einstellen
        $current_lang = $default_language;
        $current_q = 0;

        // Nun alle mitgegebenen Sprachen abarbeiten
        foreach ($accepted_languages as $accepted_language) {
                // Alle Infos �ber diese Sprache rausholen
                $res = preg_match ('/^([a-z]{1,8}(?:-[a-z]{1,8})*)'.
                                   '(?:;\s*q=(0(?:\.[0-9]{1,3})?|1(?:\.0{1,3})?))?$/i', $accepted_language, $matches);

                // war die Syntax g�ltig?
                if (!$res) {
                        // Nein? Dann ignorieren
                        continue;
                }

                // Sprachcode holen und dann sofort in die Einzelteile trennen
                $lang_code = explode ('-', $matches[1]);

                // Wurde eine Qualit�t mitgegeben?
                if (isset($matches[2])) {
                        // die Qualit�t benutzen
                        $lang_quality = (float)$matches[2];
                } else {
                        // Kompabilit�tsmodus: Qualit�t 1 annehmen
                        $lang_quality = 1.0;
                }

                // Bis der Sprachcode leer ist...
                while (count ($lang_code)) {
                        // mal sehen, ob der Sprachcode angeboten wird
                        if (in_array (strtolower (join ('-', $lang_code)), $allowed_languages)) {
                                // Qualit�t anschauen
                                if ($lang_quality > $current_q) {
                                        // diese Sprache verwenden
                                        $current_lang = strtolower (join ('-', $lang_code));
                                        $current_q = $lang_quality;
                                        // Hier die innere while-Schleife verlassen
                                        break;
                                }
                        }
                        // Wenn wir im strengen Modus sind, die Sprache nicht versuchen zu minimalisieren
                        if ($strict_mode) {
                                // innere While-Schleife aufbrechen
                                break;
                        }
                        // den rechtesten Teil des Sprachcodes abschneiden
                        array_pop ($lang_code);
                }
        }

        // die gefundene Sprache zur�ckgeben
        return $current_lang;
}

?>
