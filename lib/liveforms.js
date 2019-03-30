function dynReq(req, type, mod, zero) {
    
    target = document.getElementById(req.id+'_hint');
    
    if (zero != 1 && req.value.length==0) {
        if(type == 'v') {
            req.style.backgroundColor='#FFDDDD';
        } else {
            target.innerHTML='';
        }
        return;
    }
    
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari, …
        xmlhttp=new XMLHttpRequest();
    } else {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            if(type == 'v') {
                if(xmlhttp.responseText == '1') {
                    req.style.backgroundColor='#DDFFDD';
                } else {
                    req.style.backgroundColor='#FFDDDD';
                }
            } else {
                target.innerHTML=xmlhttp.responseText;
            }
        }
    }
    
    if(type == 'v') req.style.backgroundColor='#FFFFDD';
    
    url="lib/liveforms.php?q="+escape(req.value)+'&m='+mod;
    if(type == 'c') url += '&t='+req.id;
    xmlhttp.open("GET",url,true);
    xmlhttp.send();
}

function dynReqBlurReal(id) {
    target = document.getElementById(id);
    target.innerHTML='';
}

//Necessary on onblur before clicking on a left in the info box is executed
function dynReqBlur(req) {
    setTimeout("dynReqBlurReal('"+req.id+'_hint'+"')",250);
}




//Saves paperwork ...
function formInit() {
    var inputs=document.getElementsByTagName("input");
    for(var i=0;i<=inputs.length;i++){
        if(inputs[i] && inputs[i].name == '') {
            inputs[i].name = inputs[i].id;
        }
    }
}
window.onload=formInit;
