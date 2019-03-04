<?php

/**
 * AwSmarty
 *
 * Wrapper to load Smarty
 *
 * @package awtools
 * @author Florian Knodt <adlerweb@adlerweb.info>
 * @see http://smarty.net
 *
 * @env AW_SMARTY_CACHE  bool Disable and clear Smarty's cache
 * @env AW_SMARTY_DEBUG  bool Enable Smarty's debugging
 * @env AW_SMARTY_NOAUTO bool if defined auto-instantiate is turned off
 */

class adlerweb_smarty {

    /**
     * @var obj $s - Local smarty session
     */
    public $s;

    /**
     * Load Smarty (if not done so already) and initialize some basic stuff
     * @var string $prefix defaults to tpl - change to instanciate multiple template sessions
     */
    function __construct($prefix = 'tpl', $tpldir = 'tpl/src/', $compdir = 'tpl/compile/', $config = 'tpl/config/') {
        if(!class_exists('Smarty')) {
            if(file_exists('smarty/Smarty.class.php')) {
                require_once('smarty/Smarty.class.php');
            }elseif(file_exists('../smarty/Smarty.class.php')) {
                require_once('../smarty/Smarty.class.php');
            }elseif(file_exists('lib/smarty/libs/Smarty.class.php')) {
                require_once('lib/smarty/libs/Smarty.class.php');
            }else{
                if(!@include('Smarty.class.php')) {
                    trigger_error('Could not find Smarty', E_USER_ERROR);
                    return false;
                }
            }
        }

        $this->s = new Smarty;

        if(defined('AW_SMARTY_CACHE') && AW_SMARTY_CACHE === false) $this->s->clear_all_cache();

        if(!is_dir($tpldir)) {
            trigger_error('Template directory "'.$tpldir.'" is not accessible', E_USER_ERROR);
            return false;
        }


	if(!is_dir($compdir)) {
            trigger_error('Compile directory "'.$compdir.'" is not accessible', E_USER_ERROR);
            return false;
        }

        if(!is_dir($config)) {
            trigger_error('Configuration directory "'.$config.'" is not accessible', E_USER_ERROR);
            return false;
        }

        $this->s->template_dir = $tpldir;
        $this->s->compile_dir  = $compdir;
        $this->s->config_dir   = $config;
        if(defined('AW_SMARTY_DEBUG')) $this->s->debugging    = AW_SMARTY_DEBUG;

        $this->s->assign('currentYear', strftime("%Y", time())); //Used for copyright etc
        $this->s->assign('menue',  'session_login');
    }
}

?>
