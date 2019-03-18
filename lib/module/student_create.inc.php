<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; For navigation use &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to enter new student.'.$back);
}elseif(isset($_REQUEST['a'])
    && $_REQUEST['a'] == 'To capture'
    && isset($_REQUEST['id'])
    && isset($_REQUEST['studentNumber'])
    && isset($_REQUEST['firstName'])
    && isset($_REQUEST['surname'])
    && isset($_REQUEST['gender'])
    && isset($_REQUEST['course'])
) {
    if($_REQUEST['id'] == '0'
        && !$GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO student VALUES ('', ?, ?, ?, ?, ? )", str_repeat('s', 5), array(
            $_REQUEST['studentNumber'],
            $_REQUEST['firstName'],
            $_REQUEST['surname'],
            $_REQUEST['gender'],
            $_REQUEST['course'],
        ))
    ) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }elseif($_REQUEST['id'] != '0' && !$GLOBALS['adlerweb']['sql']->querystmt("UPDATE student SET
            `studentNumber` = ?,
            `firstName` = ?,
            `surname` = ?,
            `gender` = ?,
            `course` = ?,
            WHERE studentID = ?",
            str_repeat('s', 5).'i',
            array(
                $_REQUEST['studentNumber'],
				$_REQUEST['firstName'],
				$_REQUEST['surname'],
				$_REQUEST['gender'],
				$_REQUEST['course'],
                $_REQUEST['id']
            )
        )) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Refresh not possible');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
    }else{
        $back2='<div class="centered infobox_addtext"><a href="?m=student_list">&raquo; To the student List &raquo;</a></div>';
        $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'student successfully recorded!');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The student has been successfully transferred to the database. '.$back2);
        $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
        infomail("New student AdAr", print_r($_REQUEST, true));
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
        'studentNumber' => '',
        'firstName' => '',
        'surname' => '',
        'gender' => '',
        'course' => '',
        'studentID' => 0
    );

    $details = $dummy;
    if(isset($_REQUEST['id'])) {
		echo "andrew ";
        $details = $GLOBALS['adlerweb']['sql']->querystmt_single("SELECT * FROM student WHERE `studentID` = ?;", 'i', $_REQUEST['id']);
    }

    if(!isset($details['Country']) || $details['Country'] == '') {
        $lang = strtoupper(lang_getfrombrowser ($allowed, 'na', null, false));
    }else{
        $lang = $details['Country'];
    }

    $GLOBALS['adlerweb']['tpl']->assign('titel', 'Student Information');
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'student_create_form');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'student_create');
    $GLOBALS['adlerweb']['tpl']->assign('countries', $countries);
    $GLOBALS['adlerweb']['tpl']->assign('details', $details);
    $GLOBALS['adlerweb']['tpl']->assign('lang', $lang);
}
?>
