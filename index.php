<?PHP

/**
 * AdAr - Another dumb Archive
 *
 * Loader
 *
 * @package adar
 * @author Florian Knodt <adar@adlerweb.info>
 */
ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);

if(!file_exists('config.php') ||!is_readable('config.php')) {
    die('Missing configuration');
}

define('AW_SMARTY_NOAUTO', 1); //We use an extended version defined in func.php

require_once('config.php');                 //Config
if(file_exists('dirty.php')) require_once('dirty.php'); //Hacks for development
if(file_exists('vendor/autoload.php')) {
	require_once('vendor/autoload.php');        //Composer libraries
}else{
	die('Please install dependencies (composer install)');
}
require_once('lib/mysql.wrapper.php');      //ATools->MySQL
require_once('vendor/adlerweb/awtools/smarty.php');     //Smarty-Wrapper
require_once('lib/func.php');               //Diverses
require_once('vendor/adlerweb/awtools/session.php');    //ATools->Session-Manager

$modul='';
if(isset($_REQUEST['m'])) $modul=$_REQUEST['m'];
if(!preg_match('/[a-z]/', $modul)) {
    if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
        $modul='session_login';
    }else{
        $modul='content_list';
    }
}

if(file_exists('lib/module/'.$modul.'.inc.php')) {
    require_once('lib/module/'.$modul.'.inc.php');
}else{
    require_once('lib/module/error.inc.php');
}

if(!isset($adar_notpl)) $GLOBALS['adlerweb']['tpl']->display('main.tpl');

?>
