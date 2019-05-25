<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; For navigation use &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to upload new clusters.'.$back);
}elseif(isset($_REQUEST['a'])
    && $_REQUEST['a'] == 'To capture'
    && isset($_REQUEST['clustername'])
    && isset($_REQUEST['Description'])
) {
    if($_REQUEST['id'] == '0'
        && !$GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO cluster VALUES ('', ?, ? )", str_repeat('s', 2), array(
            $_REQUEST['clustername'],
            $_REQUEST['Description']
        ))
    ) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }elseif($_REQUEST['id'] != '0' && !$GLOBALS['adlerweb']['sql']->querystmt("UPDATE cluster SET
            `dateUpload` = ?,
            `dateModerated` = ?,
            `lecturerId` = ?,
            `moderatorId` = ?,
            `studentNumber` = ?,
            `coordinatorId` = ?,
            `clusterId` = ?,
            `publishedStatus` = ?,
            `abstract` = ?
            WHERE paperId = ?",
            str_repeat('s', 9).'i',
            array(
        $_REQUEST['dateUpload'],
				$_REQUEST['dateModerated'],
				$_REQUEST['lecturerId'],
				$_REQUEST['moderatorId'],
				$_REQUEST['studentNumber'],
				$_REQUEST['coordinatorId'],
        $_REQUEST['clusterId'],
				$_REQUEST['publishedStatus'],
        $_REQUEST['abstract'],
        $_REQUEST['id']
            )
        )) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Refresh not possible');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }else{
        $back2='<div class="centered infobox_addtext"><a href="?m=cluster_list">&raquo; View Clusters &raquo;</a></div>';
        $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Cluster Information was successfully recorded!');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Cluster Information was successfully recorded!. '.$back2);
        $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
        infomail("New user AdAr", print_r($_REQUEST, true));
    }
}else{
    $ulist = $GLOBALS['adlerweb']['sql']->query("SELECT clusterId, clustername FROM cluster;");
    $users = array();
    $allowed = array();
    while($item = $ulist->fetch_assoc()) {
        $users[]=$item;
        $allowed[]=strtolower($item['clusterId']);
    }

    $dummy = array(
        'Description' => '',
        'clustername' => '',
        'clusterId' => 0
    );

    $details = $dummy;
    if(isset($_REQUEST['id'])) {
        $details = $GLOBALS['adlerweb']['sql']->querystmt_single("SELECT * FROM cluster WHERE `clusterId` = ?;", 'i', $_REQUEST['id']);
    }
  

    $GLOBALS['adlerweb']['tpl']->assign('titel', 'Cluster Information');
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'cluster_create_form');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'cluster_create');
    $GLOBALS['adlerweb']['tpl']->assign('users', $users);
    $GLOBALS['adlerweb']['tpl']->assign('details', $details);
}
?>
