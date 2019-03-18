<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; For navigation use &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to enter new Users.'.$back);
}elseif(isset($_REQUEST['a'])
    && $_REQUEST['a'] == 'To capture'
    && isset($_REQUEST['id'])
    && isset($_REQUEST['GivenName'])
    && isset($_REQUEST['Nickname'])
    && isset($_REQUEST['Password'])
    && isset($_REQUEST['EMail'])
    && isset($_REQUEST['Level'])
    && isset($_REQUEST['UIdent'])
) {
    if($_REQUEST['id'] == '0'
        && !$GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO Users VALUES ('', ?, ?, ?, ?, ?, ? )", str_repeat('s', 6), array(
            $_REQUEST['GivenName'],
            $_REQUEST['Nickname'],
            $_REQUEST['Password'],
            $_REQUEST['EMail'],
            $_REQUEST['Level'],
            $_REQUEST['UIdent'],
        ))
    ) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }elseif($_REQUEST['id'] != '0' && !$GLOBALS['adlerweb']['sql']->querystmt("UPDATE Users SET
            `GivenName` = ?,
            `Nickname` = ?,
            `Password` = ?,
            `EMail` = ?,
            `Level` = ?,
            `UIdent` = ?,
            WHERE UserID = ?",
            str_repeat('s', 6).'i',
            array(
                $_REQUEST['GivenName'],
				$_REQUEST['Nickname'],
				$_REQUEST['Password'],
				$_REQUEST['EMail'],
				$_REQUEST['Level'],
				$_REQUEST['UIdent'],
                $_REQUEST['id']
            )
        )) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Refresh not possible');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }else{
        $back2='<div class="centered infobox_addtext"><a href="?m=user_list">&raquo; To the User List &raquo;</a></div>';
        $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'User successfully recorded!');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The user has been successfully transferred to the database. '.$back2);
        $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
        infomail("New user AdAr", print_r($_REQUEST, true));
    }
}else{
    $clist = $GLOBALS['adlerweb']['sql']->query("SELECT Alpha2, Name FROM Countries;");
    $countries = array();
    $allowed = array();
    while($item = $clist->fetch_assoc()) {
        $countries[]=$item;
        $allowed[]=strtolower($item['Alpha2']);
    }

    $dummy = array(
        'GivenName' => '',
        'Nickname' => '',
        'Password' => '',
        'EMail' => '',
        'Level' => '',
        'UIdent' => '',
        'UserID' => 0
    );

    $details = $dummy;
    if(isset($_REQUEST['id'])) {
		echo "andrew ";
        $details = $GLOBALS['adlerweb']['sql']->querystmt_single("SELECT * FROM Users WHERE `UserID` = ?;", 'i', $_REQUEST['id']);
    }

    if(!isset($details['Country']) || $details['Country'] == '') {
        $lang = strtoupper(lang_getfrombrowser ($allowed, 'na', null, false));
    }else{
        $lang = $details['Country'];
    }

    $GLOBALS['adlerweb']['tpl']->assign('titel', 'User Information');
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'user_create_form');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'user_create');
    $GLOBALS['adlerweb']['tpl']->assign('countries', $countries);
    $GLOBALS['adlerweb']['tpl']->assign('details', $details);
    $GLOBALS['adlerweb']['tpl']->assign('lang', $lang);
}
?>
