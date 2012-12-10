/* Contient les fonctions Javascript nécéssaires à l'exécution du projet */

/* Permet d'afficher la bonne division */
function ShowDiv(strDiv) {
	var tMenu = new Array("GI", "SA", "SB", "SC", "SD", "CO");
	
	var i = 0;
	for (i=0; i < tMenu.length; i++) {
		if(tMenu[i] != null) {
			if (tMenu[i] == strDiv) {
				document.getElementById(tMenu[i]).style.display="block"; 	
				document.getElementById(tMenu[i]).style.visibility="visible";
				 document.getElementById(tMenu[i]).style.height=screen.height - 368
			} else {
				document.getElementById(tMenu[i]).style.display="none";	
				document.getElementById(tMenu[i]).style.visibility="hidden";
			}
		}	
	}
}

/* Redirige vers le menu principal, en affichant un message de confirmation */
function mainPage(lang) {
	var msg; 
	var fRet; 
	msg = unsaved(lang, 'MP');
	
	fRet = confirm(msg);
	if(fRet == true) {
		location.replace("default_" + lang + ".aspx");	
	}
}

/* Redirige vers la liste des reviews, en affichant un message de confirmation */
function ReviewSearch(lang) {
	var msg; 
	var fRet; 
	msg = unsaved(lang, 'list');
	
	fRet = confirm(msg);
	if(fRet == true) {
		location.replace("ReviewSearch_" + lang + ".aspx");	
	}
}

/* Retourne le message de confirmation a afficher */
function unsaved(lang, BackTo) {
	if(lang == 'EN') {
		msg = "Unsaved information may be lost. \nAre you sure you want to get back to the ";
		if(BackTo == "MP") {
			msg += " Main Menu"
		} else {
			msg += " Review List"
		}
		msg += "?";
		} else {
		/* pour afficher des accents en Javascript, il faut mettre le caractere octal
			\351 = é **/
		msg = "Les informations non enregistr\351es seront perdues. \nVoulez-vous vraiment retourner ";
		if(BackTo == "MP") {
			msg += "au Menu Principal"
		} else {
			msg += "\340 la liste des r\351troactions"
		}
		msg += "?";
	}
	return msg;
}

/* active les bons boutons dans la recherche section employe */
function enableSearchButtons(status) {
	document.forms[0].Edit.disabled = true;
	document.forms[0].Delete.disabled = true;
	document.forms[0].View.disabled = true;
	document.forms[0].ViewCloseOut.disabled = true;
		
	if(status == 1 || status == 2) {
		document.forms[0].Edit.disabled = false;
		document.forms[0].Delete.disabled = false;
		document.forms[0].View.disabled = false;
	} else if(status == 3) {
		document.forms[0].Edit.disabled = false;
		document.forms[0].View.disabled = false;
	} else {
		document.forms[0].View.disabled = false;
		document.forms[0].ViewCloseOut.disabled = false;
	}
}

/* active les bons boutons dans la recherche section admin */
function enableReviewSearchButtons(status) {
	document.forms[0].Edit.disabled = true;
	document.forms[0].View.disabled = true;
	document.forms[0].Print.disabled = false;
			
	if(status == 2 || status == 3) {
		document.forms[0].Edit.disabled = false;
		document.forms[0].View.disabled = false;
	} else {
		document.forms[0].View.disabled = false;
		
	}
}

/* Ouvre la page d'ajout / modification d'un contact */
function Contact(mode, lang) {
	if(mode=="new") {
		window.open("Contact_" + lang + ".aspx", "new", "height=300,width=600,toolbar=no,scrollbar=no"); 
	} else if(mode=="edit") {
		var contactNo = document.forms[0].ContactName_listBox.value;
		if(contactNo == "") {
			if(lang == "EN") {
				alert("Please choose a contact");
			} else {
				alert("Veuillez s\351lectionner un contact");
			}
		} else {
			window.open("Contact_" + lang + ".aspx?Contact=" + contactNo, "new", "height=300,width=600,toolbar=no,scrollbar=no"); 
		}
	}
}

/* Ouvre la page de recherche avancée d'un client */
function CustomerSearch(lang) {
	window.open("CustomerSearch_" + lang + ".aspx", "new", "height=500,width=700,toolbar=no,scrollbar=no"); 
}

/* Ouvre la page des définitions */
function Definitions(NoDef) {
	window.open("Definitions.aspx?NoDef=" + NoDef, "new", "height=300,width=600,toolbar=no,scrollbar=no"); 
}

/* à la fin de l'enregistrement d'un feedback, lorsque l'on ferme le rapport généré, on est automatiquement redirigé vers le menu principal */
function backToMainMenu(lang) {
	var temp = location.search;
	if(temp != "") {
		window.opener.location.href="default_" + lang + ".aspx";
	} else {
		window.opener.document.forms[0].submit();
	}
}