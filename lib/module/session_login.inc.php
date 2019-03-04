<?PHP
    $GLOBALS['adlerweb']['tpl']->assign('titel', 'Log In');
    $GLOBALS['adlerweb']['tpl']->assign('menue',  'session_login');
    $back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; To main navigation;ck &laquo;</a></div>';
    $back2='<div class="centered infobox_addtext"><a href="?m=content_list">&laquo; To main navigation;ck &laquo;</a></div>';

    if($GLOBALS['adlerweb']['session']->session_isloggedin()) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'login error');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You are already as <strong>'.htmlentities($_SESSION['adlerweb']['session']['user']).'</strong> Registered.'.$back);
    }elseif(isset($_SESSION['adlerweb']['session']['retrytime']) && $_SESSION['adlerweb']['session']['retrytime'] > time()) {
        $left=ceil(($_SESSION['adlerweb']['session']['retrytime']-time())/60);
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'login error');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You have entered incorrect access data too often! Please try it in'.$left.' Minute(n) again!'.$back);
    }elseif(isset($_POST['user']) && isset($_POST['pass']) && $_POST['user'] != '' && $_POST['pass'] != '') {
        if($GLOBALS['adlerweb']['session']->session_login($_POST['user'], $_POST['pass'])) {
            $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You have been successfully registered!'.$back2);
            $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
        }else{
            $GLOBALS['adlerweb']['tpl']->assign('modul', 'session_login_form');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The credentials were incorrect!');
        }
    }else{
        $GLOBALS['adlerweb']['tpl']->assign('modul', 'session_login_form');
    }
?>
