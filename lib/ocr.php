<?php

    function ocr($file) {
        $temp=md5($file.microtime().rand());
        #Uncomment if you use tesseract <3 or have disabled jpeg/png-support
        #exec('convert '.$file.' data/tmp/'.$temp.'.tif');
        #exec('tesseract data/tmp/'.$temp.'.tif data/tmp/'.$temp.' -l deu');
        exec('tesseract '.$file.' data/tmp/'.$temp.' -l deu');
        $out='';
        if(file_exists('data/tmp/'.$temp.'.txt')) {
            $out=file_get_contents('data/tmp/'.$temp.'.txt');
            unlink('data/tmp/'.$temp.'.txt');
        }
        #if(file_exists('data/tmp/'.$temp.'.tif')) unlink('data/tmp/'.$temp.'.tif');
        return $out;
    }
    
    function crop($file, $X, $Y, $W, $H) {
        $src = imagecreatefrompng($file);
        $dst = imagecreatetruecolor($W, $H);
        
        imagecopy($dst, $src, 0, 0, $X, $Y, $W, $H);
        imagedestroy($src);
        
        $temp=md5($file.microtime().rand());
        $image='temp/'.$temp.'.png';
        imagepng($dst, $image);
        imagedestroy($dst);
        return $image;
    }
    
?>