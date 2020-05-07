
var filaselect;
function isRowSelected(sender, args) {
    var itms = sender.get_masterTableView().get_dataItems();
    var keys = sender.get_masterTableView().get_clientDataKeyNames();
    var bloqueado = false;
    var isSelected = 0;
    for (i = 0; i < itms.length; ++i) {
        isSelected = isSelected + itms[i].get_selected();
        if (itms[i].get_selected()) {
            filaselect = itms[i].getDataKeyValue(keys[0]);             
            if (itms[i].getDataKeyValue(keys[1]) == 'True')  {
                bloqueado = true;
            }
        }
    }
    if (isSelected > 1) {
        filaselect = "";
    }
    var btns = getElementsByClassName("EnabledOnOneItemSelected");
    for (i = 0; i < btns.length; ++i) {
        var btn = $find(btns[i].id);
        btn.set_enabled(isSelected == 1);       
    }

    var btns = getElementsByClassName("EnabledOnSelected");
    for (i = 0; i < btns.length; ++i) {
        var btn = $find(btns[i].id);
        btn.set_enabled(isSelected > 0);
    }

    var btns = getElementsByClassName("DisabledOnSelected");
    for (i = 0; i < btns.length; ++i) {
        var btn = $find(btns[i].id);
        btn.set_enabled(!(isSelected > 0));
    }

    if (bloqueado != false) {
        var btns = getElementsByClassName("DisabledOnSelectedBloqueado");
        for (i = 0; i < btns.length; ++i) {
            var btn = $find(btns[i].id);
            btn.set_enabled(false);
        }
    }

}
function ActivarPanel(elemento, visibilidad) {
    element = document.getElementById(elemento)
    if (visibilidad!=0) {    
        element.style.display = 'block';
    }
    else {
        element.style.display = 'none';
    }
}
var popUp;
function CentrarPopup(sender, eventArgs) {
    popUp = eventArgs.get_popUp();
    var ancho = window.innerWidth;
    var alto = window.innerHeight;
    var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
    var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
    var versionExplorador = getInternetExplorerVersion();
   if ( versionExplorador > 8 || versionExplorador == -1 ) {
    popUp.style.left = parseInt((ancho - popUpWidth) / 2) + "px";
    popUp.style.top = parseInt((alto - popUpHeight) / 2) + "px";
    }
}
 
function GridCommand(sender, arg) {
    if (arg.get_commandName() != "Edit") {
        editedRow = null
    }
}

function GridCreated(sender, eventArgs) {
    var gridElement = sender.get_element();
    var elementsToUse = [];
    inputs = gridElement.getElementsByTagName("input");
    for (var i = 0; i < inputs.length; i++) {
        var lowerType = inputs[i].type.toLowerCase();
        if (lowerType == "hidden" || lowerType == "button") {
            continue;
        }

        Array.add(elementsToUse, inputs[i]);
        inputs[i].onchange = TrackChanges;
    }

    dropdowns = gridElement.getElementsByTagName("select");
    for (var i = 0; i < dropdowns.length; i++) {
        dropdowns[i].onchange = TrackChanges;
    }

    setTimeout(function () { if (elementsToUse[0]) elementsToUse[0].focus(); }, 100);
}

function TrackChanges(e) {
    hasChanges = true;
}

function DobleClickRedir(sender, arg) {
    id = arg.getDataKeyValue('cliId');
    location.href = "cliente.aspx?cliId=" + id +"&Modo=Editar";
}
function DobleClickProveedor(sender, arg) {
    id = arg.getDataKeyValue('ProId');
    location.href = "proveedor.aspx?cliId=" + id + "&Modo=Editar";
}
function DobleClickDocumento(sender, arg) {
    id = arg.getDataKeyValue('docId');
    parent.location.href = "documento.aspx?docId=" + id;
}
function AbrirVentana(nombre, url) {
    var contenedor = GetRadWindowManager();
    var ventana = contenedor.GetWindowByName(nombre);
    if (!url) {
        ventana.Show();
    }
    else {
        ventana.SetUrl(url);
        ventana.Show();
    }
}

function AbrirVentanaMP(nombre) {
    var ventana = $find(nombre);
    ventana.Show();
}   

function CerrarDialogo() {
    var ventana = window.frameElement.radWindow;
    ventana.Close();
}
function VolverAtras() {
    location.href = document.referrer;   
}
function Preguntar(sender, arg) {   
    if (!confirm("¿Está seguro que desea eliminar este registro?")) {
        arg.set_cancel(true);
    }
}
function ValidCCC(sender, args) {
    args.IsValid = false;
    var ccc = args.Value;
    ccc = ccc.replace(/-/g, '').replace(/ /g, '');
    if (ccc.length == 20) {
        var bancoEntidad = ccc.substring(0, 8);
        var numeroCuenta = ccc.substring(10, 20);
        var digitoControl = ccc.substring(8, 10);

        var d1 = getDigito(bancoEntidad);
        var d2 = getDigito(numeroCuenta);

        if ('' + d1 + d2 == digitoControl) {
            args.IsValid = true;
        }
    }
    return;
}

function getDigito(arg) {
    var s = 0;
    var c;
    var r;

    s += arg.charAt(0) * 1;
    s += arg.charAt(1) * 2;
    s += arg.charAt(2) * 4;
    s += arg.charAt(3) * 8;
    s += arg.charAt(4) * 5;
    s += arg.charAt(5) * 10;
    s += arg.charAt(6) * 9;
    s += arg.charAt(7) * 7;
    s += arg.charAt(8) * 3;
    s += arg.charAt(9) * 6;

    c = Math.floor(s / 11);
    r = s - (c * 11);
    s = 11 - r;

    if (s == 11) { s = 0 }
    if (s == 10) { s = 1 }

    return s;
}

function validNIF(sender, args) {
        var res = getTipoFiscal(args.Value);
        args.IsValid = false;
        if (res > 0) {
            args.IsValid = true;
        }
    
    return;
}

function getTipoFiscal(a) {
    var temp = a.toUpperCase();
    var cadenadni = "TRWAGMYFPDXBNJZSQVHLCKE";
    if (temp == '') {
        return 4;
    }
    if (temp !== '') {
        //si no tiene un formato valido devuelve error
        if ((!/^[A-Z]{1}[0-9]{7}[A-Z0-9]{1}$/.test(temp) && !/^[T]{1}[A-Z0-9]{8}$/.test(temp)) && !/^[0-9]{8}[A-Z]{1}$/.test(temp)) {
            return 0;
        }

        //comprobacion de NIFs estandar
        if (/^[0-9]{8}[A-Z]{1}$/.test(temp)) {
            posicion = a.substring(8, 0) % 23;
            letra = cadenadni.charAt(posicion);
            var letradni = temp.charAt(8);
            if (letra == letradni) {
                return 1;
            }
            else {
                return -1;
            }
        }

        //algoritmo para comprobacion de codigos tipo CIF
        suma = parseInt(a[2]) + parseInt(a[4]) + parseInt(a[6]);
        for (i = 1; i < 8; i += 2) {
            temp1 = 2 * parseInt(a[i]);
            temp1 += '';
            temp1 = temp1.substring(0, 1);
            temp2 = 2 * parseInt(a[i]);
            temp2 += '';
            temp2 = temp2.substring(1, 2);
            if (temp2 == '') {
                temp2 = '0';
            }

            suma += (parseInt(temp1) + parseInt(temp2));
        }
        suma += '';
        n = 10 - parseInt(suma.substring(suma.length - 1, suma.length));

        //comprobacion de NIFs especiales (se calculan como CIFs)
        if (/^[KLM]{1}/.test(temp)) {
            if (a[8] == String.fromCharCode(64 + n)) {
                return 1;
            }
            else {
                return -1;
            }
        }

        //comprobacion de CIFs
        if (/^[ABCDEFGHJNPQRSUVW]{1}/.test(temp)) {
            temp = n + '';
            if (a[8] == String.fromCharCode(64 + n) || a[8] == parseInt(temp.substring(temp.length - 1, temp.length))) {
                return 2;
            }
            else {
                return -2;
            }
        }

        //comprobacion de NIEs
        //T
        if (/^[T]{1}/.test(temp)) {
            if (a[8] == /^[T]{1}[A-Z0-9]{8}$/.test(temp)) {
                return 3;
            }
            else {
                return -3;
            }
        }

        //XYZ
        if (/^[XYZ]{1}/.test(temp)) {
            pos = str_replace(['X', 'Y', 'Z'], ['0', '1', '2'], temp).substring(0, 8) % 23;
            if (a[8] == cadenadni.substring(pos, pos + 1)) {
                return 3;
            }
            else {
                return -3;
            }
        }
    }

    return 0;
}



function str_replace(search, replace, subject) {
    var f = search, r = replace, s = subject;
    var ra = r instanceof Array, sa = s instanceof Array, f = [].concat(f), r = [].concat(r), i = (s = [].concat(s)).length;

    while (j = 0, i--) {
        if (s[i]) {
            while (s[i] = s[i].split(f[j]).join(ra ? r[j] || "" : r[0]), ++j in f) { };
        }
    };

    return sa ? s : s[0];
}
/*
	Developed by Robert Nyman, http://www.robertnyman.com
	Code/licensing: http://code.google.com/p/getelementsbyclassname/
*/	
var getElementsByClassName = function (className, tag, elm){
	if (document.getElementsByClassName) {
		getElementsByClassName = function (className, tag, elm) {
			elm = elm || document;
			var elements = elm.getElementsByClassName(className),
				nodeName = (tag)? new RegExp("\\b" + tag + "\\b", "i") : null,
				returnElements = [],
				current;
			for(var i=0, il=elements.length; i<il; i+=1){
				current = elements[i];
				if(!nodeName || nodeName.test(current.nodeName)) {
					returnElements.push(current);
				}
			}
			return returnElements;
		};
	}
	else if (document.evaluate) {
		getElementsByClassName = function (className, tag, elm) {
			tag = tag || "*";
			elm = elm || document;
			var classes = className.split(" "),
				classesToCheck = "",
				xhtmlNamespace = "http://www.w3.org/1999/xhtml",
				namespaceResolver = (document.documentElement.namespaceURI === xhtmlNamespace)? xhtmlNamespace : null,
				returnElements = [],
				elements,
				node;
			for(var j=0, jl=classes.length; j<jl; j+=1){
				classesToCheck += "[contains(concat(' ', @class, ' '), ' " + classes[j] + " ')]";
			}
			try	{
				elements = document.evaluate(".//" + tag + classesToCheck, elm, namespaceResolver, 0, null);
			}
			catch (e) {
				elements = document.evaluate(".//" + tag + classesToCheck, elm, null, 0, null);
			}
			while ((node = elements.iterateNext())) {
				returnElements.push(node);
			}
			return returnElements;
		};
	}
	else {
		getElementsByClassName = function (className, tag, elm) {
			tag = tag || "*";
			elm = elm || document;
			var classes = className.split(" "),
				classesToCheck = [],
				elements = (tag === "*" && elm.all)? elm.all : elm.getElementsByTagName(tag),
				current,
				returnElements = [],
				match;
			for(var k=0, kl=classes.length; k<kl; k+=1){
				classesToCheck.push(new RegExp("(^|\\s)" + classes[k] + "(\\s|$)"));
			}
			for(var l=0, ll=elements.length; l<ll; l+=1){
				current = elements[l];
				match = false;
				for(var m=0, ml=classesToCheck.length; m<ml; m+=1){
					match = classesToCheck[m].test(current.className);
					if (!match) {
						break;
					}
				}
				if (match) {
					returnElements.push(current);
				}
			}
			return returnElements;
		};
	}
	return getElementsByClassName(className, tag, elm);
};
function getInternetExplorerVersion()
// Returns the version of Windows Internet Explorer or a -1
// (indicating the use of another browser).
{
   var rv = -1; // Return value assumes failure.
   if (navigator.appName == 'Microsoft Internet Explorer')
   {
      var ua = navigator.userAgent;
      var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
      if (re.exec(ua) != null)
         rv = parseFloat( RegExp.$1 );
   }
   return rv;

}

function formatNumber(value, decimals) {
    value = decimals > 0 ? value.toFixed(decimals) : value += '';
    var x = value.split('.');
    var i = x[0];
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(i)) {
        i = i.replace(rgx, '$1' + '.' + '$2');
    }

    var d;

    if (decimals == 0) {
        d = '';
    }
    if (decimals > 0) {
        d = x.length > 1 ? ',' + x[1] : ',';
        d = d + '0000000000';
        d = d.substring(0, decimals + 1);
    }
    if (decimals < 0) {
        d = x.length > 1 ? ',' + x[1] : '';
    }
       return i + d;
}

function parseNumber(value) {
    return value.replace(".", "").replace(",", ".");
}

    function PrintPage(sender, args) {
        window.print();
}

    function wordcounter(obj, event, maxi, div) {
    //Función usada en la ventana de messages.aspx
    //Muestra al usuario la cantidad de caracteres que faltan para completar el mensaje
    var elem = obj.value;
    var info = document.getElementById(div);
    info.innerHTML = maxi - elem.length;
    }

    function getradimagescr(radimage, div) {
        var radim = document.getElementById(radimage);
        var info = document.getElementById(div);
        info.innerHTML = radim.scr;
    }

