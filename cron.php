<?PHP

/**
 * AdAr - Another dumb Archive
 *
 * System zur Archivierung von Fotos und Dokumenten
 *
 * @package adar
 * @author Florian Knodt <adlerweb@adlerweb.info>
 */

if(!file_exists('config.php') ||!is_readable('config.php')) {
    die('Konfiguration fehlt');
}
require_once('config.php');                 //Config
require_once('lib/mysql.wrapper.php');      //ATools->MySQL
require_once('lib/ocr.php');

//Step 1: Temp Cleanup
echo "Temp Cleanup\n";
$dir = opendir('data/tmp/');
while (($file = readdir($dir)) !== false) {
    if(filetype('data/tmp/' . $file) == 'file' && filectime('data/tmp/' . $file) <= time()-(12*60*60)) {
        echo "  Delete: data/tmp/".$file."\n";
        unlink('data/tmp/' . $file);
    }
}
closedir($dir);
echo "DONE!\n";

//Step 2: OCR
echo "OCR...\n";
$list = $GLOBALS['adlerweb']['sql']->query('SELECT ItemID,Description FROM `Items` WHERE OCRStatus = 1');
if($list->num_rows > 0) {
    while($item = $list->fetch_object()) {
        echo "  ORC for ".$item->ItemID."\n";
        $ocr='';
        if(file_exists('data/org/'.$item->ItemID.'.png')) {
            echo "    PNG OCR\n";
            $ocr = ocr('data/org/'.$item->ItemID.'.png');
        }elseif(file_exists('data/org/'.$item->ItemID.'.jpg')) {
            echo "    JPG OCR\n";
            $ocr = ocr('data/org/'.$item->ItemID.'.jpg');
        }elseif(file_exists('data/org/'.$item->ItemID.'.pdf')) {
            echo "    PDF TXT...";
            exec('pdftotext -layout data/org/'.$item->ItemID.'.pdf data/tmp/'.$item->ItemID.'.txt');
            if(!file_exists('data/tmp/'.$item->ItemID.'.txt') || !($text = file_get_contents('data/tmp/'.$item->ItemID.'.txt')) || strlen(trim($text)) < 100) {
                echo "FAILED\n    PDF OCR\n";
                //Fallback to optical method
                exec('convert -density 400 '.escapeshellarg('data/org/'.$item->ItemID.'.pdf').' '.escapeshellarg('data/tmp/'.$item->ItemID.'.png'));
                $page=0;
                do {
                    $ocr .= ocr('data/tmp/'.$item->ItemID.'-'.$page.'.png');
                    unlink('data/tmp/'.$item->ItemID.'-'.$page.'.png');
                    $page++;
                } while(file_exists('data/tmp/'.$item->ItemID.'-'.$page.'.png'));
            }else{
                echo "OK\n";
                $ocr = $text;
            }
            if(file_exists('data/tmp/'.$item->ItemID.'.txt')) unlink('data/tmp/'.$item->ItemID.'.txt');
        }else{
            echo "No original?!\n";
        }

        if($ocr != '') {
            $desc = '';
            if($item->Description != '') {
                $desc = $item->Description."\n\n---\n\n.";
            }
            $desc .= $ocr;
            $GLOBALS['adlerweb']['sql']->querystmt("UPDATE `Items` SET `Description` = ?, `OCRStatus` = 2 WHERE ItemID = ?;", 'ss', array($desc, $item->ItemID));
            echo "    Added ".strlen($ocr)." chars\n";
        }
    }
}
echo "DONE!\n";

?>
