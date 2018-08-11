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
			String tabla = request.getParameter("hddTabla") == null ? "" : request.getParameter("hddTabla"), 
					motor = request.getParameter("hddMotor") == null ? "" : request.getParameter("hddMotor"),
					campos = request.getParameter("hddCols") == null ? "" : request.getParameter("hddCols"), 
					valores = request.getParameter("hddvals") == null ? "" : request.getParameter("hddvals"),
					tipos = request.getParameter("hddtipos") == null ? "" : request.getParameter("hddtipos");
			
		DBConexion.creaRegistro(motor, tabla, campos, tipos, valores);
	%>

	<script type="text/javascript">
		alert("Registro Guardado Satisfactoriamente");
		parent.document.forms["frmSaveRecord"].reset();
		parent.document.getElementById('divNuevo').style.display ='none';
	</script>
	
	<%
		} catch (Exception e) {
			e.printStackTrace();
	%>
	<i><strong><%=e.getMessage()%></strong></i>
	<script type="text/javascript">
		alert( "<%=e.getMessage().replaceAll("\n", "")%>" );
	</script>
	<%
		}
	%>
</body>
</html>