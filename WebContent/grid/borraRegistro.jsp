<%@page import="ni.per.berroteran.lkf.ejemplos.conexion.DBConexion"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<%
		try {
			//Recuperando parametros
			String tabla = request.getParameter("txtTabla") == null ? ""
					: request.getParameter("txtTabla"), filtro = request
					.getParameter("txtFiltro") == null ? "" : request
					.getParameter("txtFiltro"),
					index = request.getParameter("hddIndice") == null ? "0" : request.getParameter("hddIndice");

			//valida
			if ( tabla.equals(""))
				throw new Exception("Error al querer eliminar, no puedo recuperar la tabla");
			
			if ( filtro.equals(""))
				throw new Exception("Error al querer eliminar, no recibi el parametro FILTRO (Que eliminar?)");
			//procede
			DBConexion.borraRegistro(tabla, filtro);
	%>
	<script type="text/javascript">
		parent.document.getElementById('frmBorra').reset();
		parent.document.getElementById("tGrid").deleteRow(<%=index%>);
	</script>
	<%
		} catch (Exception e) {
	%>
	<script type="text/javascript">
		alert( "Error al intentar eliminar el registro : <%=e.getMessage()%>");
	</script>
	<%
		}
	%>
</body>
</html>