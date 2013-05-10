function toggle_visibility(target, source) {
    target = document.getElementById(target);
    if(source.checked == true) {
        target.style.display='none';
    } else {
        target.style.display='block';
    }
}
