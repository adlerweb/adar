<?PHP
    $GLOBALS['adlerweb']['session']->session_logout();
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'Logout erfolgreich');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Sie wurden erfolgreich abgemeldet<div class="centered infobox_addtext"><a href="?m=">&laquo; Zur&uuml;ck &laquo;</a></div>');
    $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
    $GLOBALS['adlerweb']['tpl']->assign('menue',  'session_logout');
?>
