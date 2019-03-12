<?PHP

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'Keine Berechtigung');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Sie haben nicht die n&ouml;tigen Rechte um diese Seite aufzurufen.');
}else{
<<<<<<< HEAD
    $titel = 'Listenansicht';
=======
    $titel = 'List View'; //list view
>>>>>>> c1d1b4578081235e271fe0f89d9f569f480c09aa

    $GLOBALS['adlerweb']['tpl']->assign('titel', $titel);
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'content_list_boot');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'content_list');
}
?>
