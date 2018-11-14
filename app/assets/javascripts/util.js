// Fetches the value of a field from a cookie
// Arg: name of key for which to return value
function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

// Show contextual menus in header, based on whether user is signed in
function menu() {
  if (document.cookie.indexOf("remember_token") != -1) { // If signed in
    $("menu_out").hide();
    $("menu_in").show();  // More menu options when signed in
    $("user").show();  // 'Signed in as <username>'
    $("username").update(readCookie('username'));  // Update actual username
    $("username").show()
  } else { // Signed out
    $("menu_out").show();
    $("menu_in").hide();
    $("user").hide()
  };
}
