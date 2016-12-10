function listCookies() {
    var theCookies = document.cookie.split(';');
    var aString = '';
    for (var i = 1 ; i <= theCookies.length; i++) {
        aString += i + ' ' + theCookies[i-1] + "\n";
    }
    return aString;
}

/*ciastka:
mały fragment tekstu, który serwis internetowy wysyła do przeglądarki i który przeglądarka wysyła z powrotem 
przy następnych wejściach na witrynę. Używane jest głównie do utrzymywania sesji np. poprzez wygenerowanie 
i odesłanie tymczasowego identyfikatora po logowaniu. Może być jednak wykorzystywane szerzej poprzez 
zapamiętanie dowolnych danych, które można zakodować jako ciąg znaków. Dzięki temu użytkownik nie musi 
wpisywać tych samych informacji za każdym razem, gdy powróci na tę stronę lub przejdzie z jednej strony na inną.
*/ 