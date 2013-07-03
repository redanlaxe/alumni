function appelAjaxExemple() {
    ajaxCallRemotePage('ajaxAction.do');
}

function ajaxCallRemotePage(url) {
    if (window.XMLHttpRequest)
    {
        // Non-IE browsers       	
        req = new XMLHttpRequest();
        req.onreadystatechange = processStateChange;
        req.open("GET", url, true);
        req.setRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT");
        req.send(null);
    }
    else if (window.ActiveXObject)
    {
        // IE       	
        req = new ActiveXObject("Microsoft.XMLHTTP");
        req.onreadystatechange = processStateChange;
        req.open("GET", url, true);
        req.setRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT");
        req.send();
    }
    else {
        return; // Navigateur non compatible 	
    }
}
