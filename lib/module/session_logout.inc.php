<?PHP
    $GLOBALS['adlerweb']['session']->session_logout();
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'Logout erfolgreich');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
<<<<<<< HEAD
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Sie wurden erfolgreich abgemeldet<div class="centered infobox_addtext"><a href="?m=">&laquo; Zur&uuml;ck &laquo;</a></div>');
=======
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'They were successfully logout<div class="centered infobox_addtext"><a href="?m=">&laquo; To main navigation; &laquo;</a></div>');
>>>>>>> c1d1b4578081235e271fe0f89d9f569f480c09aa
    $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
    $GLOBALS['adlerweb']['tpl']->assign('menue',  'session_logout');
?>
