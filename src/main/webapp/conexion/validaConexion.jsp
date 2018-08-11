<%@page import="java.util.List"%>
<% 
  response.setHeader("Pragma", "no-cache");
  response.setHeader("Cache-Control", "no-cache");
  response.setDateHeader("Expires", 0);
  response.setHeader("Cache-Control","no-store" );
  response.setHeader("Cache-Control","private" );
%>
<%@ page session="true"%>

<%@page import="ni.per.berroteran.lkf.ejemplos.conexion.DBConexion"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
	try{
		//Recuperando parametros
		String	motor = request.getParameter("cboMotor") == null ? "" : request.getParameter("cboMotor"),
				host  =  request.getParameter("txthost") == null ? "" : request.getParameter("txthost"), 
				sport  =  request.getParameter("txtport") == null ? "0" : request.getParameter("txtport"),
				db    =  request.getParameter("txtDB") == null ? "" : request.getParameter("txtDB"),
				user  = request.getParameter("txtusuario") == null ? "" : request.getParameter("txtusuario"),
				clave = request.getParameter("txtclave") == null ? "" : request.getParameter("txtclave");
		
		//validando variables
		int port = Integer.parseInt(sport);
		if ( port == 0 )
			throw new Exception("Puerto de conexion indicado Invalido");
		
		//ejecutando metodo
		DBConexion.validaConexion(motor, host, port, user, clave, db);

		
		//listo todo OK
		%>
	<script type="text/javascript">
			<!-- Cambiando indicador de estado  -->
			parent.document.getElementById("divEstatus").innerHTML = "conectado";
			parent.document.getElementById("divEstatus").setAttribute("class","divEstadoON");
						
		</script>

	<!-- Actaulizando Base de  datos. -->
	<div id="tdDataBase">
		<select name="txtDB" onchange="fnJavascript:actualizaTablas();">
			<option value="">Seleccione ...</option>
			<%for ( String dbname : DBConexion.getAllDataBases() ){ %>
			<option value="<%=dbname%>"><%=dbname%></option>
			<%} %>
		</select>
	</div>
	<script type="text/javascript">
			parent.document.getElementById("tdDataBase").innerHTML = document.getElementById("tdDataBase").innerHTML;
			
			//actualizando lista de tablas.
			parent.actualizaTablas();
		</script>

	<!-- TODO OK -->

	<%}catch(NumberFormatException ne){
		%>
	<script type="text/javascript">
			parent.document.getElementById("divEstatus").innerHTML = "ERROR";
			parent.document.getElementById("divEstatus").setAttribute("class","divEstadoError");
			alert("El puerto de Conexion indicado no es valido");
		</script>
	<%
	}catch(Exception e){
		e.printStackTrace();
		%>
	<script type="text/javascript">
			parent.document.getElementById("divEstatus").innerHTML = "ERROR";
			parent.document.getElementById("divEstatus").setAttribute("class","divEstadoError");
			alert("<%=e.getMessage().replace("\n", " ").replace("\r", " ")%>");
		</script>
	<%
	}
	%>
</body>
</html>