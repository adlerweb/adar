<?PHP
    /* imgwrapper downloadschutz */
    $adar_notpl=true;

    $id=$_GET['id'];
    if(!isset($id) || !preg_match('/^[A-Z]{2}_[0-9]{4}$/', $id)) {
        $img = 'vendor/koala-framework/library-silkicons/cross.png';
    }elseif(isset($_REQUEST['org'])) {
        if(file_exists('data/org/'.$id.'.png')) {
            header('Content-Type: image/png');
            echo file_get_contents('data/org/'.$id.'.png');
        }elseif(file_exists('data/org/'.$id.'.jpg')) {
            header('Content-Type: image/jpeg');
            echo file_get_contents('data/org/'.$id.'.jpg');
        }elseif(file_exists('data/org/'.$id.'.pdf')) {
            header('Content-Type: application/pdf');
            echo file_get_contents('data/org/'.$id.'.pdf');
        }else{
            header('Content-Type: image/png');
            echo file_get_contents('vendor/koala-framework/library-silkicons/cross.png');
        }

    }else{
        $detail=$GLOBALS['adlerweb']['sql']->querystmt_exists('Items', 'ItemID', 's', $id);
        if(
            !$detail ||
            (isset($_REQUEST['page'])  && !file_exists('data/cache/'.$id.'-'.(int)$_REQUEST['page'].'.png')) ||
            (!isset($_REQUEST['page']) && !file_exists('data/cache/'.$id.'.png'))
        ){
            $img = 'vendor/koala-framework/library-silkicons/cross.png';
        }else{
            if(!isset($_REQUEST['page'])) {
                $img = 'data/cache/'.$id.'.png';
            }else{
                $img = 'data/cache/'.$id.'-'.(int)$_REQUEST['page'].'.png';
            }
        }
    }

    header('Content-Type: image/png');
    echo file_get_contents($img);
?>
