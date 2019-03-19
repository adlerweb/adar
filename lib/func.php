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

// Determine browser language
// Those: http://aktuell.de.selfhtml.org/artikel/php/httpsprache/
function lang_getfrombrowser ($allowed_languages, $default_language, $lang_variable = null, $strict_mode = true) {
        // $_SERVER['HTTP_ACCEPT_LANGUAGE'] use if no language variable was specified
        if ($lang_variable === null) {
               $lang_variable = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
        }

        // was any information sent?
        if (empty($lang_variable)) {
                // No=> Return standard language
                return $default_language;
         }

        // Split the header
        $accepted_languages = preg_split('/,\s*/', $lang_variable);

        // Set the default values
        $current_lang = $default_language;
        $current_q = 0;

        // Now complete all given languages
        foreach ($accepted_languages as $accepted_language) {
                // Get all info about this language
                $res = preg_match ('/^([a-z]{1,8}(?:-[a-z]{1,8})*)'.
                                   '(?:;\s*q=(0(?:\.[0-9]{1,3})?|1(?:\.0{1,3})?))?$/i', $accepted_language, $matches);

                // was the syntax valid?
                if (!$res) {
                        // No? Then ignore it
                        continue;
                }

                // Get language code and then immediately split into the items
                $lang_code = explode ('-', $matches[1]);

                // Was a quality given?
                if (isset($matches[2])) {
                        // to use the quality
                        $lang_quality = (float)$matches[2];
                } else {
                        // Compatibility mode: accept quality 1
                        $lang_quality = 1.0;
                }

                // Until the language code is empty ...
                while (count ($lang_code)) {
                        // Let's see if the language code is offered
                        if (in_array (strtolower (join ('-', $lang_code)), $allowed_languages)) {
                                // Look at quality
                                if ($lang_quality > $current_q) {
                                        // use this language
                                        $current_lang = strtolower (join ('-', $lang_code));
                                        $current_q = $lang_quality;
                                        // Here leave the inner while loop
                                        break;
                                }
                        }
                        // If we are in strict mode, do not try to minimize the language
                        if ($strict_mode) {
                                // break inside while loop
                                break;
                        }
                        // cut off the most right part of the language code
                        array_pop ($lang_code);
                }
        }

        // to return the found language
        return $current_lang;
}

?>
