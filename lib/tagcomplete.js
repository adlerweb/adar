function tagAdd(field, editor, tags, tag, val) {

    if(val == '') return;
    tagstatus = -1;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari, …
        xmlhttp=new XMLHttpRequest();
    } else {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4) {
            if(xmlhttp.status==200) {
                tagstatus=1;
            }else{
                tagstatus=0;
                alert("Tag add failed!")
            }
        }
    }

    url  = "index.php?m=content_detail&id=";
    url += encodeURIComponent(document.getElementById('ItemID').value);
    url += "&action=addtag&tag=";
    url += encodeURIComponent(val);

    start = Math.floor(Date.now() / 1000);

    xmlhttp.open("GET",url,true);
    xmlhttp.send();

    /*any better ideas?*/
    /*while(true) {
        if(Math.floor(Date.now() / 1000) > (start + 2000)) {
            return false;
        }
        if(tagstatus == 1) return val;
        if(tagstatus == 0) return false;
    }*/
    return;
}

function tagDel(field, editor, tags, val) {

    if(val == '') return true;
    tagstatus = -1;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari, …
        xmlhttp=new XMLHttpRequest();
    } else {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4) {
            if(xmlhttp.status==200) {
                tagstatus=1;
            }else{
                tagstatus=0;
                alert("Tag delete failed!")
            }
        }
    }

    url  = "index.php?m=content_detail&id=";
    url += encodeURIComponent(document.getElementById('ItemID').value);
    url += "&action=deltag&tag=";
    url += encodeURIComponent(val);

    start = Math.floor(Date.now() / 1000);

    xmlhttp.open("GET",url,true);
    xmlhttp.send();

    /*any better ideas?*/
    /*while(true) {
        if(Math.floor(Date.now() / 1000) > (start + 2000)) {
            return false;
        }
        if(tagstatus == 1) return true;
        if(tagstatus == 0) return false;
    }*/
    return true;
}
