<%@page import="java.util.List"%>
<%@page import="ni.per.berroteran.lkf.ejemplos.conexion.DBConexion"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
try{
	//Recuperando parametros
	String	db = request.getParameter("txtDB") == null ? "" : request.getParameter("txtDB"),
			tabla = request.getParameter("cboTabla") == null ? "" : request.getParameter("cboTabla");

	List<String> listaT = DBConexion.getAllTables(db);
	
	List<String> listaS = DBConexion.getShemas(db);
	%>
	<select style="width: 423px;" name="cboTabla" id="cboTabla">
		<option value="">Seleccione Tabla</option>
		<%
		for ( String s : listaT){
			out.println("<option value='"+s+"' "+ (s.equals("") ? "selected=\"selected\"" : "")+ " >"+s+"</option>");
		}
		%>
	</select>

	<select style="width: 423px;" name="cboEsquema" id="cboEsquema">
		<option value="">Seleccione Schema</option>
		<%
		for ( String s : listaS){
			out.println("<option value='"+s+"'>"+s+"</option>");
		}
		%>
	</select>


	<script type="text/javascript">
		parent.document.getElementById('cboTabla').innerHTML = document.getElementById('cboTabla').innerHTML;  
		parent.document.getElementById('cboEsquema').innerHTML = document.getElementById('cboEsquema').innerHTML;
	</script>
	<%
}catch(Exception e){
	%>
	<script type="text/javascript">
		alert("Error al intentar Recuperar las tablas.");
	</script>
	<%
}
%>
</body>
</html>