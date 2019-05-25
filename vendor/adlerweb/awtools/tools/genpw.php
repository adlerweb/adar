<?PHP

/**
 * AdAr - Adlerweb's Archiv
 *
 * Passworterstellung
 *
 * @package adar
 * @author Florian Knodt <adlerweb@adlerweb.info>
 */

error_reporting(E_ALL);
 
require('../lib/awtools/session.php');

if(isset($argv) && isset($argv[1])) {
    $pw = $argv[1];
}elseif(isset($_REQUEST) && isset($_REQUEST['p'])) {
    $pw = $_REQUEST['p'];
}else{
    $pw = 'test';
}

$sess = new adlerweb_session;
var_dump($sess->session_getNewPasswordHash($pw));

 ?>
