<?PHP
    $GLOBALS['adlerweb']['session']->session_logout();
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'Logout successful');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You have been successfully logged out<div class="centered infobox_addtext"><a href="?m=">Back</a></div>');
    $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
    $GLOBALS['adlerweb']['tpl']->assign('menue',  'session_logout');
?>
