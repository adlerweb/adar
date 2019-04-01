<?PHP
/**
 * DiFlAS - Digitales Flachgut-Archiv Saffig
 *
 * System for archiving photos and documents
 *
 * @package diflas
 * @author Florian "adlerweb" Knodt <adlerweb@adlerweb.info>
 */

session_start();
require_once('../config.php');
require_once('mysql.wrapper.php');
require_once('../vendor/adlerweb/awtools/session.php');

if(!isset($_GET['q']) || !isset($_GET['m'])) {
    die('Error…');
}

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    die('Please login…');
}

$q=urldecode($_GET['q']);

switch($_GET['m']) {
    case 'ItemID':
        if(!preg_match("/^\d{4}$/", $q)) die('0');
        $detail=$GLOBALS['adlerweb']['sql']->querystmt_exists('Items', 'ItemID', 's', $_SESSION['adlerweb']['session']['short']."_".$q);
        if(!$detail) die('0');
        die('1');
    case 'Format':
        if(!isset($_GET['t']) || $_GET['t']=='') die('');
        if(!preg_match('/^[\w\d\s,\-]*$/', $q)) $q='';
        $detail=$GLOBALS['adlerweb']['sql']->querystmt("SELECT COUNT(Format) as ANZ, Format FROM `Items` WHERE Format IS NOT NULL AND Format LIKE ? GROUP BY Format ORDER BY ANZ DESC", 's', '%'.$q.'%');
        if(!$detail) die();
        echo '<ul>';
        foreach($detail as $f) {
            echo '<li><a href="#" onclick="document.getElementById(\''.htmlentities($_GET['t']).'\').value=\''.htmlentities($f['Format']).'\';">'.htmlentities($f['Format']).'</a></li>';
        }
        echo '</ul>';
        exit();
    case 'Contact':
        if(!isset($_GET['t']) || $_GET['t']=='') die('');
        if(!preg_match('/^[\w\d\s,\-\.|]*$/', $q)) $q='';
        $detail=$GLOBALS['adlerweb']['sql']->querystmt("SELECT FamilyName, GivenName FROM `Contacts` WHERE FamilyName LIKE ? OR GivenName LIKE ? ORDER BY FamilyName", 'ss', array('%'.$q.'%', '%'.$q.'%'));
        if(!$detail) die();
        echo '<ul>';
        foreach($detail as $f) {
            echo '<li><a href="#" onclick="document.getElementById(\''.htmlentities($_GET['t'], ENT_COMPAT, 'UTF-8').'\').value=\''.htmlentities($f['FamilyName'], ENT_COMPAT, 'UTF-8').', '.htmlentities($f['GivenName'], ENT_COMPAT, 'UTF-8').'\';">'.htmlentities($f['FamilyName'], ENT_COMPAT, 'UTF-8').', '.htmlentities($f['GivenName'], ENT_COMPAT, 'UTF-8').'</a></li>';
        }
        echo '</ul>';
        exit();
    case 'Tags':
        if(!isset($_GET['term']) || $_GET['term']=='') die('[]');
        $detail=$GLOBALS['adlerweb']['sql']->querystmt("SELECT TagValue FROM `Tags` WHERE TagValue LIKE ? GROUP BY TagValue", 's', $_GET['term'].'%');
        if(!$detail) die('[]');
        $out = array();
        foreach($detail as $do) $out[] = $do['TagValue'];
        echo json_encode($out);
        exit();
    default:
        die('Error…');
}

?>
