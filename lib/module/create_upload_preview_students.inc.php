<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; For navigation use &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to access this page.');
}else{

	$titel = 'Students Upload From excel'; //list view
    $GLOBALS['adlerweb']['tpl']->assign('titel', $titel);
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'create_students_upload');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'create_upload_preview_students');	
	}
?>
