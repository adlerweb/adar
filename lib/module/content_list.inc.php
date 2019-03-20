<?PHP

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'Keine Berechtigung');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Sie haben nicht die n&ouml;tigen Rechte um diese Seite aufzurufen.');
}else{

    $titel = 'List View'; //list view

    $GLOBALS['adlerweb']['tpl']->assign('titel', $titel);
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'content_list_boot');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'content_list');
}
?>
