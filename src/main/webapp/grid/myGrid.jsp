<!--  
Como pueden ver, no estoy utilizando AJAX
 -->
<%@page import="java.sql.Types"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="ni.per.berroteran.lkf.ejemplos.conexion.DBConexion"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<% 
  response.setHeader("Pragma", "no-cache");
  response.setHeader("Cache-Control", "no-cache");
  response.setDateHeader("Expires", 0);
  response.setHeader("Cache-Control","no-store" );
  response.setHeader("Cache-Control","private" );
%>
<%@ page session="true"%>

<%! public boolean esChar(int tipo){
	//Cree este metodo aqui, para demostrar que se puede, aunque no es una buena practica, ademas estamos haciendo algo rustico
	boolean T = false;
	
	return T;
}%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Estilos -->
<link rel="stylesheet" type="text/css" href="../css/default.css" />

<!-- Archivos Scripts relacionados -->
<script type="text/javascript" src="../js/fnRegistros.js"></script>

<!--  Scripts incrustado -->
<script type="text/javascript">
		var varTMP;
		function guardarRec(td){
			alert('Guardado,jijijiji');
			td.outerHTML = varTMP;
		}
		function editarRec(td, tr, cols){
			varTMP = td;
			tds = tr.getElementsByTagName('td');
			for (var i=0; i< cols;i++){
				var valor = tds[i].innerHTML;
				console.log("TipoValor: " + typeof valor);
				valor = valor.trim();
				if ( valor != "-" ){
					tds[i].innerHTML = '<input name="" value="'+valor+'" >';
				} 
			}
			tds[i].innerHTML="<button onclick='javascript:guardarRec(this)'>Guardar</botton>";
		}
	</script>

<body>
	<%
	try{
		//Recuperando parametros
		String	tabla = request.getParameter("cboTabla") == null ? "" : request.getParameter("cboTabla"),
					db     =  request.getParameter("txtDB") == null ? "" : request.getParameter("txtDB"),
					motor   =  request.getParameter("cboMotor") == null ? "" : request.getParameter("cboMotor");;
		//run
		System.out.println("Tabla recuperada en MyGRID: " + tabla);
		//Recuperando la llave de la tabla.
		String llave = DBConexion.getLlaveTabla(db, tabla);
		//Intentando recuperar los parametros. 
		ResultSet registros = DBConexion.getInfoTable(tabla);
		ResultSetMetaData meta = registros.getMetaData();
		%>
	<button type="button"
		onclick="javascript:fnAddNewRec(document.getElementById('divNuevo') );">
		<img src="../img/add.gif"> [N]Nuevo
	</button>
	
	<div id="divNuevo" style="display: none;">
	
		<form name="frmSaveRecord" action="saveRegistro.jsp" target="ifrmProcesaGrid" method="post">
			<input type="hidden" name="hddTabla" value="<%=tabla%>" />
			<input type="hidden" name="hddMotor" value="<%=motor%>" />
			<table id="tnewRecord">
				<!-- Encabezado -->
				<tr class="HeadTableNuevo">
					<%
						String cols = "";
						for (int i=1;i<=meta.getColumnCount();i++){
							cols = cols.concat( cols.length()> 1 ? ",": "" );
							cols = cols.concat( meta.isAutoIncrement(i) ? "" : meta.getColumnName(i) );
							%>
					<th id="thead"><%=meta.getColumnName(i)%> <%=(meta.isAutoIncrement(i) ? "[*]" : "" ) %>
						<%if ( llave.contains(meta.getColumnName(i) )){ %> <img
						src="../img/key.png" /> <%} %></th>
					<%} %>
					<td colspan="2"></td>
				</tr>
				<!-- Nuevo registro -->
				<tr>
					<%for (int i=1;i<=meta.getColumnCount();i++){%>
					<td>
						<%if( meta.isAutoIncrement(i) ){ %> <i>-</i> <%}else{ 
							//utilizo los sql.types para validar, el tipo 15 es el tipo String %>
						<input type="text" field="<%=meta.getColumnName(i)%>" tipo="<%=meta.getColumnType(i)%>" />
					</td>
					<%}%>
				<%}
					//creando cadena para guardar
					%>
					<td colspan="2">
						<button type="submit" onclick="javascript:fnSaveRecord(this.parentNode.parentNode);">
							<img src="../img/save.png" /> ::Guardar
						</button>
					</td>
				</tr>
			</table>
			<input type="hidden" name="hddCols" value="<%=cols%>" />
			<input type="hidden" name="hddvals" value="" id="hddvals" />
			<input type="hidden" name="hddtipos" value="" id="hddtipos" />
			<i style="font-size: 12px; color: red;">NOTA: Para tipos String color entre commillas, por ahora debe ser asi.</i>
			<i style="font-size: 10px;">Nota: Los campos autogenerados(numericos u alfanums)[*] no permite ingresan valor, el Ícono de llave indica que es parte de la PrimaryKey.</i>				
		</form>
	</div>


	<table border="1" id="tGrid">
		<!-- Encabezado -->
		<tr class="HeadTable">
			<%for (int i=1;i<=meta.getColumnCount();i++){%>
			<th id="thead"><%=meta.getColumnName(i)%> <%=(meta.isAutoIncrement(i) ? "[*]" : "" ) %></th>
			<%} %>
			<td colspan="2"></td>
		</tr>
		<!-- Datos -->
		<!-- Coloco los primeras columnas como filtro/llave, porque en la mayoria de las tablas las llaves estan de primero, recuerden, es una muestra/ejemplo  -->
		<%for ( int i=1; i < meta.getColumnCount();i++){
				
				while(registros.next()){
				String cadenaDEL = "";%>
		<tr>
			<%for (int j=1;j<=meta.getColumnCount();j++){%>
			<td><%=registros.getString(j)%></td>
			<%} %>
			<td>
				<img src="../img/bot_lap_gris.gif" onclick="javascript:editarRec(this.parentNode, this.parentNode.parentNode,<%=meta.getColumnCount()%> );" onmouseover="this.src='../img/bot_lap.gif'" onmouseout="this.src='../img/bot_lap_gris.gif'" />
			</td>
			<%
					//creando cadena a pasar al boton eliminar para poder proceder, lo importante, obviamente es la llave
					
					if ( llave.contains( meta.getColumnName(i) ) ){
						if ( cadenaDEL.length() > 2 )
							cadenaDEL = cadenaDEL.concat(" and ");
						cadenaDEL = cadenaDEL.concat( meta.getColumnName(i) + " = '" + registros.getString(i) + "' " );
					}
					%>
			<td>
				<button type="submit" onclick='javascript:fnBorrarRec( this.parentNode.parentNode, this.getAttribute("cadena") );' cadena="<%=cadenaDEL%>">
					<img src="../img/delete.gif">
				</button>
			</td>
		</tr>
		<%}
			}%>
	</table>
	<br/>
	...
	<div style="">
		<iframe name="ifrmProcesaGrid" id="ifrmProcesaGrid" height="100" width="100%" frameborder="0"></iframe>
			<form name="frmBorra" id="frmBorra" method="post" target="ifrmProcesaGrid" action="borraRegistro.jsp">
				<input type="hidden" name="txtTabla" value="<%=tabla%>" />
				<input type="hidden" name="txtFiltro" value="" id="txtFiltroDEL" />
				<input type="hidden" name="hddIndice" value="" id="hddIndice" />
		</form>
	</div>
	.
	<%}catch(Exception e){
		e.printStackTrace();
		out.print(e);
	}%>
</body>

</html>