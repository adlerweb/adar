<?PHP
    $GLOBALS['adlerweb']['tpl']->assign('titel', 'Anmelden');
    $GLOBALS['adlerweb']['tpl']->assign('menue',  'session_login');
<<<<<<< HEAD
    $back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; Zur&uuml;ck &laquo;</a></div>';
    $back2='<div class="centered infobox_addtext"><a href="?m=content_list">&laquo; Zur&uuml;ck &laquo;</a></div>';
=======
    $back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; To main navigation; &laquo;</a></div>';
    $back2='<div class="centered infobox_addtext"><a href="?m=content_list">&laquo; To main navigation; &laquo;</a></div>';
>>>>>>> c1d1b4578081235e271fe0f89d9f569f480c09aa

    if($GLOBALS['adlerweb']['session']->session_isloggedin()) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Anmeldefehler');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Sie sind bereits als <strong>'.htmlentities($_SESSION['adlerweb']['session']['user']).'</strong> angemeldet.'.$back);
    }elseif(isset($_SESSION['adlerweb']['session']['retrytime']) && $_SESSION['adlerweb']['session']['retrytime'] > time()) {
        $left=ceil(($_SESSION['adlerweb']['session']['retrytime']-time())/60);
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Anmeldefehler');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Sie haben zu oft fehlerhafte Zugangsdaten eingegeben! Bitte versuchen sie es in '.$left.' Minute(n) erneut!'.$back);
    }elseif(isset($_POST['user']) && isset($_POST['pass']) && $_POST['user'] != '' && $_POST['pass'] != '') {
        if($GLOBALS['adlerweb']['session']->session_login($_POST['user'], $_POST['pass'])) {
            $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Sie wurden erfolgreich angemeldet!'.$back2);
            $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
        }else{
            $GLOBALS['adlerweb']['tpl']->assign('modul', 'session_login_form');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Die Anmeldedaten waren nicht korrekt!');
        }
    }else{
        $GLOBALS['adlerweb']['tpl']->assign('modul', 'session_login_form');
    }
?>
