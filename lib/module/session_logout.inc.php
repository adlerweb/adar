<?PHP
    $GLOBALS['adlerweb']['session']->session_logout();
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'Logout Successful');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You are successfully logout<div class="centered infobox_addtext"><a href="?m=">&laquo; To main navigation &laquo;</a></div>');
    $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
    $GLOBALS['adlerweb']['tpl']->assign('menue',  'session_logout');
?>
