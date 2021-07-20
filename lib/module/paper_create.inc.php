<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; For navigation use &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to upload new papers.'.$back);
}elseif(isset($_REQUEST['a'])
    && $_REQUEST['a'] == 'To capture'
    && isset($_REQUEST['id'])

    && isset($_REQUEST['Dateupload'])
    && isset($_REQUEST['DateModerated'])
    && isset($_REQUEST['lecturerID'])
    && isset($_REQUEST['ModeratorID'])
    && isset($_REQUEST['StudentID'])
    && isset($_REQUEST['CoordinatorID'])
    && isset($_REQUEST['clusterID'])
    && isset($_REQUEST['publishStatus'])
) {
    if($_REQUEST['id'] == '0'
        && !$GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO papers VALUES ('', ?, ?, ?, ?, ?, ? )", str_repeat('s', 8), array(
            $_REQUEST['Dateupload'],
            $_REQUEST['DateModerated'],
            $_REQUEST['lecturerID'],
            $_REQUEST['ModeratorID'],
            $_REQUEST['StudentID'],
            $_REQUEST['CoordinatorID'],
            $_REQUEST['clusterID'],
            $_REQUEST['publishStatus'],

        ))
    ) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }elseif($_REQUEST['id'] != '0' && !$GLOBALS['adlerweb']['sql']->querystmt("UPDATE papers SET

            `Dateupload` = ?,
            `DateModerated` = ?,
            `lecturerID` = ?,
            `ModeratorID` = ?,
            `StudentID` = ?,
            `CoordinatorID` = ?,
            `clusterID` = ?,
            `publishStatus` = ?,
            WHERE UserID = ?",
            str_repeat('s', 8).'i',
            array(
                $_REQUEST['Dateupload'],
				$_REQUEST['DateModerated'],
				$_REQUEST['lecturerID'],
				$_REQUEST['ModeratorID'],
				$_REQUEST['StudentID'],
				$_REQUEST['CoordinatorID'],
                $_REQUEST['clusterID'],
				$_REQUEST['publishStatus'],

                $_REQUEST['id']
            )
        )) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Refresh not possible');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }else{

        $back2='<div class="centered infobox_addtext"><a href="?m=paper_list">&raquo; To the paper List &raquo;</a></div>';

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

        'Dateupload' => '',
        'DateModerated' => '',
        'lecturerID' => '',
        'ModeratorID' => '',
        'StudentID' => '',
        'CoordinatorID' => '',
        'clusterID' => '',
        'publishStatus' => '',
        'PaperID' => 0

    );

    $details = $dummy;
    if(isset($_REQUEST['id'])) {

        $details = $GLOBALS['adlerweb']['sql']->querystmt_single("SELECT * FROM papers WHERE `paperID` = ?;", 'i', $_REQUEST['id']);

    }

    if(!isset($details['Country']) || $details['Country'] == '') {
        $lang = strtoupper(lang_getfrombrowser ($allowed, 'na', null, false));
    }else{
        $lang = $details['Country'];
    }

    $GLOBALS['adlerweb']['tpl']->assign('titel', 'Paper Information');
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'paper_create_form');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'paper_create');
    $GLOBALS['adlerweb']['tpl']->assign('countries', $countries);
    $GLOBALS['adlerweb']['tpl']->assign('details', $details);
    $GLOBALS['adlerweb']['tpl']->assign('lang', $lang);
}
?>
