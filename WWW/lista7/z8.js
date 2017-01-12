function listCookies() {
    var theCookies = document.cookie.split(';');
    var aString = '';
    for (var i = 1 ; i <= theCookies.length; i++) {
        aString += i + ' ' + theCookies[i-1] + "\n";
    }
    return aString;
}

/*The HttpOnly attribute directs browsers not to expose cookies through channels other than HTTP (and HTTPS) requests. 
This means that the cookie cannot be accessed via client-side scripting languages (notably JavaScript), 
and therefore cannot be stolen easily via cross-site scripting (a pervasive attack technique)*/ 