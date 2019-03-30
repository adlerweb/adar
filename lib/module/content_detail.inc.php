<?PHP
    if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to access this page.');
    }else{
        if(!isset($_GET['id']) || !preg_match('/^[A-Z]{2}_[0-9]{4}$/', $_GET['id'])) {
            $GLOBALS['adlerweb']['tpl']->assign('titel',  'No entries');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errico', 'exclamation');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There are no entries in our archive that match your search criteria.');
        }else{
            $id=$_GET['id'];
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
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errico', 'exclamation');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There are no entries in our archive that match your search criteria.');
            }elseif(!file_exists('data/cache/'.$id.'.png') && !file_exists('data/cache/'.$id.'-0.png')) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Data Error');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errico', 'exclamation');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The record is corrupt');
            }else{
                if(isset($_REQUEST['action']) && $_REQUEST['action'] == 'addtag' && $GLOBALS['adlerweb']['session']->session_isloggedin()) {
                    if(!isset($_REQUEST['tag'])) {
                        http_response_code(400);
                        die();
                    }
                    if(!$GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO `Tags` VALUES ( NULL , ?, ?);", 'ss', array($detail['ItemID'], $_REQUEST['tag']))) {
                        http_response_code(400);
                        die();
                    }
                    infomail("New day picture ".$detail['ItemID'], $_REQUEST['tag']);
                    http_response_code(200);
                    echo '[]';
                    die();
                }elseif(isset($_REQUEST['action']) && $_REQUEST['action'] == 'deltag' && isset($_REQUEST['tag']) && $GLOBALS['adlerweb']['session']->session_isloggedin()) {
                    if(!$GLOBALS['adlerweb']['sql']->querystmt("DELETE FROM `Tags` WHERE ItemID = ? AND TagValue = ? LIMIT 1;", 'ss', array($detail['ItemID'], $_REQUEST['tag']))) {
                        http_response_code(400);
                        die();
                    }
                    infomail("Tag deleted image ".$detail['ItemID'], $_REQUEST['tag']);
                    http_response_code(200);
                    echo '[]';
                    die();
                }

                $tags = $GLOBALS['adlerweb']['sql']->querystmt("SELECT TagValue FROM Tags WHERE ItemID = ?;", 's', $detail['ItemID']);
                $tagarr=array();
                if($tags) {
                    foreach($tags as $tag) {
                        $tagarr[] = $tag['TagValue'];
                    }
                }

                if(file_exists('data/cache/'.$id.'.png')) {
                    $multi=false;
                }else{
                    $multi=0;
                    while(file_exists('data/cache/'.$id.'-'.$multi.'.png')) {
                        $multi++;
                    }
                }

                if(isset($tagarr)) $GLOBALS['adlerweb']['tpl']->assign('Tags', implode(',', $tagarr));

                $GLOBALS['adlerweb']['tpl']->assign('ItemID', htmlentities($detail['ItemID'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('Caption', htmlentities($detail['Caption'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('Description', htmlentities($detail['Description'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('Format', htmlentities($detail['Format'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('Date', ($detail['Date'] !== NULL) ? htmlentities(strftime("%d.%m.%Y", strtotime($detail['Date'])), ENT_COMPAT, 'UTF-8') : '' );
                $GLOBALS['adlerweb']['tpl']->assign('R_CID', htmlentities($detail['R_CID'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('R_FamilyName', htmlentities($detail['R_FamilyName'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('R_GivenName', htmlentities($detail['R_GivenName'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('S_CID', htmlentities($detail['S_CID'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('S_FamilyName', htmlentities($detail['S_FamilyName'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('S_GivenName', htmlentities($detail['S_GivenName'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('ScanUser', htmlentities($detail['Name'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('ScanDate', htmlentities(strftime("%d.%m.%Y", strtotime($detail['ScanDate'])), ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('SourceSHA256', chunk_split(htmlentities($detail['SourceSHA256'], ENT_COMPAT, 'UTF-8'), 8, ' '));
                $GLOBALS['adlerweb']['tpl']->assign('pages', $multi);
                $GLOBALS['adlerweb']['tpl']->assign('titel', 'Detailansicht '.htmlentities($id));
                $GLOBALS['adlerweb']['tpl']->assign('modul', 'content_detail');
                $GLOBALS['adlerweb']['tpl']->assign('REQUEST_URI', $_SERVER["REQUEST_URI"]);
            }
        }
    }
?>

