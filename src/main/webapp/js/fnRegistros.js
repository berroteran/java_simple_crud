/**
 * Funciones de registros
 */

function fnBorrarRec(tr, cadena) {
	if ( confirm('Esta seguro que desea borrar este registro') ){
		console.log(tr);
		console.log("Cadena a borrar: " + cadena);
		document.getElementById('txtFiltroDEL').value = cadena;
		document.getElementById("hddIndice").value = tr.rowIndex;
		document.getElementById('frmBorra').submit();
	}  
}

function fnEditarRec(c1, v1, c2, v1) {

}

function fnAddNewRec(nuevo) {
	if ( nuevo.style.display == ''){
		nuevo.style.display = 'none';
	}else{
		nuevo.style.display = '';
	};
	
}

function fnSaveRecord(tr){
	console.log(tr);
	var inputs = tr.getElementsByTagName('input');
	var cadena = "";
	var tipos = "";
	
	for (var z=0; z < inputs.length; z++){
		if ( cadena.length > 0 )
			cadena = cadena + ", ";
		if ( tipos.length > 0 )
			tipos = tipos + ", ";
		cadena = cadena +  inputs[z].value;
		tipos = tipos + inputs[z].getAttribute("tipo");
	}
	document.getElementById("hddvals").value = cadena;
	document.getElementById("hddtipos").value = tipos;
	document.forms["frmSaveRecord"].submit();
	//document.getElementById('tGrid').push(tr);
}


function fnAddNewRecNOuse(tabla, x) {
	var newRow = tabla.insertRow();
	for (var i=0;i<x;i++){
		var ccell = newRow.insertCell();
			ccell.innerHTML = '<input type="text" />';
	}
	var newBoton = newRow.insertCell();
		newBoton.setAttribute("colspan","2");
		newBoton.innerHTML = '<button type="button" onclick="javascript:" >Guardar</button>';
	
}
