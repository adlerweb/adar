<?PHP

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to access this page.');
}else{
    $titel = 'User List'; //list view

    $GLOBALS['adlerweb']['tpl']->assign('titel', $titel);
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'user_list');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'user_list');
	
}

	function getUsers() {
    //if(!preg_match("|^(.+), ([^,]*)$|", $name, $match)) return false;
    $detail=$GLOBALS['adlerweb']['sql']->query("SELECT UserID, Name, Nickname, EMail, Level, UIdent FROM users");
    if(!$detail) return false;
    return $detail;
}
?>
