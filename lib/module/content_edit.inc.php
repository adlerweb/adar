<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; Zur&uuml;ck &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'Keine Berechtigung');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Sie haben nicht die n&ouml;tigen Rechte um Archivst&uuml;cke zu bearbeiten.'.$back);
} elseif(!isset($_REQUEST['id']) || !preg_match('/^[A-Z]{2}_[0-9]{4}$/', $_REQUEST['id'])) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'Keine Eintr&auml;ge');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errico', 'exclamation');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'In unserem Archiv befinden sich keine Eintr&auml;ge, welche ihren Suchkriterien entsprechen.');
}elseif(isset($_REQUEST['a']) && $_REQUEST['a'] == 'Editieren') {
    $format = '';

    if(isset($_REQUEST['FormatTop']) && $_REQUEST['FormatTop'] != '') $format = $_REQUEST['FormatTop'];
    if(isset($_REQUEST['Format']) && $_REQUEST['Format'] != '') $format = $_REQUEST['Format'];

    if(!isset($_REQUEST['Sender']) || !isset($_REQUEST['Receiver']) || !($cids=getcontacts($_REQUEST['Sender'], $_REQUEST['Receiver']))) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Editieren nicht moeglich');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Die Kontakte konnten nicht zugeordnet werden.'.$back);
    }elseif(($GLOBALS['adlerweb']['sql']->querystmt("UPDATE Items
        SET 
            Caption = ?,
            Description = ?,
            Format = ?,
            Date = ?,
            Sender = ?,
            Receiver = ?,
            OCRStatus = ?
        WHERE
            ItemID = ?;",
        str_repeat('s', 8), array(
            $_REQUEST['Caption'],
            $_REQUEST['Description'],
            $format,
            $_REQUEST['Date'],
            $cids['s'],
            $cids['r'],
            $_REQUEST['OCR'],
            $_REQUEST['id'],
    ))) === false) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Erfassen nicht moeglich');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Es ist ein Datenbankfehler aufgetreten #103.'.$back);
    }else{
        $back2='<div class="centered infobox_addtext"><a href="?m=content_detail&id='.urlencode($_REQUEST['id']).'">&raquo; Zur Detailseite &raquo;</a></div>';
        $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Archivgut erfolgreich editiert!');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Das Archivgut wurde erfolgreich in der Datenbank geändert.'.$back2);
        $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
        infomail("Editiertes Archivgut AdAR", $_REQUEST['Caption']);
    }
}else{
    $id=$_REQUEST['id'];
    $sqlq="SELECT
            `Items`.*,
            `Users`.*,
            `Receiver`.`CID` as 'R_CID',
            `Receiver`.`FamilyName` as 'R_FamilyName',
            `Receiver`.`GivenName` as 'R_GivenName',
            `Sender`.`CID` as 'S_CID',
            `Sender`.`FamilyName` as 'S_FamilyName',
            `Sender`.`GivenName` as 'S_GivenName'
        FROM
            `Items`
            LEFT JOIN `Users` ON `Items`.`ScanUser` = `Users`.`UserID`
            LEFT JOIN `Contacts` AS `Sender` ON `Items`.`Sender` = `Sender`.`CID`
            LEFT JOIN `Contacts` AS `Receiver` ON `Items`.`Receiver` = `Receiver`.`CID`
            WHERE `ItemID` = ?";
    $sqlq.=" LIMIT 1;";
    $detail=$GLOBALS['adlerweb']['sql']->querystmt_single($sqlq, 's', $id);
    if(!$detail) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Keine Eintr&auml;ge');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errico', 'exclamation');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'In unserem Archiv befinden sich keine Eintr&auml;ge, welche ihren Suchkriterien entsprechen.');
    }elseif(!file_exists('data/cache/'.$id.'.png') && !file_exists('data/cache/'.$id.'-0.png')) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Datenfehler');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errico', 'exclamation');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Der Datensatz ist korrupt');
    }else{
        $GLOBALS['adlerweb']['tpl']->assign('edit', true);
        $GLOBALS['adlerweb']['tpl']->assign('hash', $detail['SourceSHA256']);
        $GLOBALS['adlerweb']['tpl']->assign('id', $id);
        $GLOBALS['adlerweb']['tpl']->assign('date', htmlentities($detail['Date']));
        $GLOBALS['adlerweb']['tpl']->assign('descr', htmlentities($detail['Description']));
        $GLOBALS['adlerweb']['tpl']->assign('ScanDate', htmlentities($detail['ScanDate']));
        $GLOBALS['adlerweb']['tpl']->assign('ScanUser', htmlentities($detail['Name']));
        $GLOBALS['adlerweb']['tpl']->assign('ScanUserShort', $_SESSION['adlerweb']['session']['short']);
        $GLOBALS['adlerweb']['tpl']->assign('Format', htmlentities($detail['Format']));
        $GLOBALS['adlerweb']['tpl']->assign('Caption', htmlentities($detail['Caption']));
        $GLOBALS['adlerweb']['tpl']->assign('From', htmlentities($detail['S_FamilyName'].', '.$detail['S_GivenName']));
        $GLOBALS['adlerweb']['tpl']->assign('To', htmlentities($detail['R_FamilyName'].', '.$detail['R_GivenName']));
        $GLOBALS['adlerweb']['tpl']->assign('OCRStatus', htmlentities($detail['OCRStatus']));
        $GLOBALS['adlerweb']['tpl']->assign('titel', 'Inhalt Editieren - '.htmlentities($_REQUEST['id']));
        $GLOBALS['adlerweb']['tpl']->assign('modul', 'create_form');
        $GLOBALS['adlerweb']['tpl']->assign('menue', 'content_edit');
    }
}

function getcontacts($s, $r) {
    $out['s'] = getcontact($s);
    $out['r'] = getcontact($r);
    if($out['s'] == false || $out['r'] == false) return fhtmlentities($detail['Caption']);
    return $out;
}

function getcontact($name) {
    if(!preg_match("|^(.+), ([^,]*)$|", $name, $match)) return false;
    $detail=$GLOBALS['adlerweb']['sql']->querystmt_single("SELECT CID FROM `Contacts` WHERE FamilyName LIKE ? AND GivenName LIKE ?", 'ss', array($match[1], $match[2]));
    if(!$detail) return false;
    return $detail['CID'];
}
?>
