<%@page import="ni.per.berroteran.lkf.ejemplos.tags.Combo"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Demo CRUD en Java por Omar Berroteran</title>
<!-- Estilos -->
<link rel="stylesheet" type="text/css" href="css/default.css" />
<script type="text/javascript">
		function validaMotor(motor){
			switch (motor) {
			case "postgres":
				document.forms['frmCRUD'].txtport.value = "5432"; 
				break;
			case "sqlite":
				document.forms['frmCRUD'].txtport.value = "80"; 
				break;
			case "h2":
				document.forms['frmCRUD'].txtport.value = "20"; 
				break;
			case "mysql":
				document.forms['frmCRUD'].txtport.value = "3306"; 
				break;
			case "mssql":
				document.forms['frmCRUD'].txtport.value = "1433"; 
				break;
			default:
				break;
			}
		}
		
		function fnValidaConexion(){
			document.getElementById("divEstatus").innerHTML = "Procesando";
			parent.document.getElementById("divEstatus").setAttribute("class","divEstado");
			document.forms['frmCRUD'].target = "ifrmActiones";
			document.forms['frmCRUD'].action = "conexion/validaConexion.jsp";
			document.forms['frmCRUD'].submit();
			document.getElementById('ifrmGRID').location = 'empty.html';
			document.getElementById('ifrmGRID').location.replace(true);
		}
		function actualizaTablas(){
			document.forms['frmCRUD'].target = "ifrmActiones";
			document.forms['frmCRUD'].action = "conexion/getTablas.jsp";
			document.forms['frmCRUD'].submit();
			document.getElementById('ifrmGRID').location = 'empty.html';
			document.getElementById('ifrmGRID').location.replace(true);

		}
		function fnCargaTabla(){
			document.getElementById('ifrmGRID').location = 'empty.html';
			document.getElementById('ifrmGRID').location.replace(true);

			document.forms['frmCRUD'].target = "ifrmGRID";
			document.forms['frmCRUD'].action = "grid/myGrid.jsp";
			document.forms['frmCRUD'].submit();
		}
	</script>

</head>

<body>
	<h1>Ejemplo de CRUD using JAVA, JSP y Servlet por Omar Berroteran</h1>
	<h3>CRUD (Create, Retrieve, Update y Delete) ::Pure HTML,
		Javascript, DHTML. Este es un metodo utilizando lo mas basico</h3>
	<br />
	<form action="" target="ifrmActiones" name="frmCRUD" id="frmCRUD">
		<table class="tablaUno" cellpadding="0" cellspacing="0" border="1">
			<tr>
				<td width="50">Motor</td>
				<td><select style="width: 138px;" name="cboMotor"
					onchange="javascript:validaMotor(this.value);">
						<option value="">Seleccione</option>
						<option value="postgres">PostgreSQL</option>
						<option value="sqlite">SQLite</option>
						<option value="h2">H2</option>
						<option value="mysql">MySQL</option>
						<option value="mssql">MS SQL Server (6+)</option>
				</select></td>
				<td colspan="6"></td>
			</tr>
			<tr>
				<td>Servidor/Host</td>
				<td style="width: 60px;"><input type="text" name="txthost"
					style="width: 200px;" value="localhost"></td>
				<td width="60px">Puerto</td>
				<td width="50"><input type="text" name="txtport" width="50px;"
					style="width: 50px;"></td>
				<td>BaseDeDatos</td>
				<td id="tdDataBase"><input type="text" name="txtDB" /></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan=8 class="separador" height="1"></td>
			</tr>
			<tr>
				<td>Usuario</td>
				<td width="100"><input type="text" name="txtusuario"></td>
				<td>Clave</td>
				<td><input type="password" name="txtclave" /></td>
				<td>&nbsp;</td>
				<td bordercolor="blue"><input type="button" name="btnOK"
					value="[C]Conectar" onclick="javascritp:fnValidaConexion();"></td>
				<td><div id="divEstatus" class="divEstado">Desconectado</div></td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table>
			<tr>
				<td>Esquema</td>
				<td><select style="width: 136px;" name="cboEsquema"
					id="cboEsquema"></select></td>
				<td>Tabla</td>
				<td colspan="3"><select style="width: 423px;" name="cboTabla"
					id="cboTabla"></select></td>
				<td></td>
				<td><input type="button" name="btnOK" value="Cargar"
					onclick="javascritp:fnCargaTabla();"></td>
			</tr>
		</table>
	</form>
	<br />
	<center>

		<iframe src="empty.html" width="95%" height="500px" name="ifrmGRID"
			id="ifrmGRID"></iframe>
	</center>
	<br />
	<hr>

	<iframe src="empty.html" width="0" height="0" name="ifrmActiones"
		id="ifrmActiones"></iframe>
</body>
</html>