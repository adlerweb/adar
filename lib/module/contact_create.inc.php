<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; For navigation use &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to enter new contacts.'.$back);
}elseif(isset($_REQUEST['a'])
    && $_REQUEST['a'] == 'To capture'
    && isset($_REQUEST['id'])
    && isset($_REQUEST['FamilyName'])
    && isset($_REQUEST['GivenName'])
    && isset($_REQUEST['Type'])
    && isset($_REQUEST['Street'])
    && isset($_REQUEST['Housenr'])
    && isset($_REQUEST['ZIP'])
    && isset($_REQUEST['City'])
    && isset($_REQUEST['Country'])
    && isset($_REQUEST['Phone'])
    && isset($_REQUEST['Fax'])
    && isset($_REQUEST['Mail'])
    && isset($_REQUEST['URL'])
    && isset($_REQUEST['Notes'])
) {
    if($_REQUEST['id'] == '0'
        && !$GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO Contacts VALUES ('', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )", str_repeat('s', 13), array(
            $_REQUEST['FamilyName'],
            $_REQUEST['GivenName'],
            $_REQUEST['Type'],
            $_REQUEST['Street'],
            $_REQUEST['Housenr'],
            $_REQUEST['ZIP'],
            $_REQUEST['City'],
            $_REQUEST['Country'],
            $_REQUEST['Phone'],
            $_REQUEST['Fax'],
            $_REQUEST['Mail'],
            $_REQUEST['URL'],
            $_REQUEST['Notes'],
        ))
    ) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }elseif($_REQUEST['id'] != '0' && !$GLOBALS['adlerweb']['sql']->querystmt("UPDATE Contacts SET
            `FamilyName` = ?,
            `GivenName` = ?,
            `Type` = ?,
            `Street` = ?,
            `Housenr` = ?,
            `ZIP` = ?,
            `City` = ?,
            `Country` = ?,
            `Phone` = ?,
            `Fax` = ?,
            `Mail` = ?,
            `URL` = ?,
            `Notes` = ?,
            WHERE CID = ?",
            str_repeat('s', 13).'i',
            array(
                $_REQUEST['FamilyName'],
                $_REQUEST['GivenName'],
                $_REQUEST['Type'],
                $_REQUEST['Street'],
                $_REQUEST['Housenr'],
                $_REQUEST['ZIP'],
                $_REQUEST['City'],
                $_REQUEST['Country'],
                $_REQUEST['Phone'],
                $_REQUEST['Fax'],
                $_REQUEST['Mail'],
                $_REQUEST['URL'],
                $_REQUEST['Notes'],
                $_REQUEST['id']
            )
        )) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Refresh not possible');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }else{
        $back2='<div class="centered infobox_addtext"><a href="?m=content_detail&id='.$itemid.'">&raquo; To the detail page &raquo;</a></div>';
        $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Contact successfully recorded!');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The contact has been successfully transferred to the database.');
        $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
        infomail("New contact AdAr", print_r($_REQUEST, true));
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
        'FamilyName' => '',
        'GivenName' => '',
        'Type' => '',
        'Street' => '',
        'Housenr' => '',
        'ZIP' => '',
        'City' => '',
        'Country' => '',
        'Phone' => '',
        'Fax' => '',
        'Mail' => '',
        'URL' => '',
        'Notes' => '',
        'CID' => 0
    );

    $details = $dummy;
    if(isset($_REQUEST['id'])) {
        $details = $GLOBALS['adlerweb']['sql']->querystmt_single("SELECT * FROM Contacts WHERE `CID` = ?;", 'i', $_REQUEST['id']);
    }

    if(!isset($details['Country']) || $details['Country'] == '') {
        $lang = strtoupper(lang_getfrombrowser ($allowed, 'na', null, false));
    }else{
        $lang = $details['Country'];
    }

    $GLOBALS['adlerweb']['tpl']->assign('titel', 'Contact Gathering');
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'contact_create_form');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'contact_create');
    $GLOBALS['adlerweb']['tpl']->assign('countries', $countries);
    $GLOBALS['adlerweb']['tpl']->assign('details', $details);
    $GLOBALS['adlerweb']['tpl']->assign('lang', $lang);
}
?>
