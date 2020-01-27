package ni.per.berroteran.lkf.ejemplos.conexion;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * User: omar berroteran Date: 7/14/13 Time: 8:20 PM To change
 * 
 */
public class DBConexion {
  static Logger logg = LogManager.getLogger(DBConexion.class);

  // variables staticas de conexion
  /**
   * La conexion es estatica porque es una prueba, si fuse produccion se utilizaria un pool de conexiones adminsitrados por un gestor.
   */
  static Connection conn = null;
  static String motor = "";
  static String dbName = "";

  static Statement stmt;
  static Statement stmtUp;

  // Determina si hay una conexcion establecida.
  private static boolean isConnSetup = false;

  public static Connection validaConexion(String dbms, String serverName, int portNumber, String userName, String password, String dbNameIni) throws Exception {
    dbName = dbNameIni;
    motor = dbms;
    Properties connectionProps = new Properties();
    connectionProps.put("user", userName);
    connectionProps.put("password", password);

    if (dbms.equals("postgres")) {
      Class.forName("org.postgresql.Driver");
      conn = DriverManager.getConnection("jdbc:postgresql://" + serverName + ":" + portNumber + "/" + dbName, connectionProps);
    } else if (dbms.equals("sqlite")) {
      Class.forName("org.sqlite.JDBC");
      conn = DriverManager.getConnection("jdbc:sqlite:" + dbName, connectionProps);
    } else if (dbms.equals("h2")) {
      Class.forName("org.h2.Driver");
      conn = DriverManager.getConnection("jdbc:h2://" + serverName + ":" + portNumber + "/" + dbName, connectionProps);
    } else if (dbms.equals("mysql")) {
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName, connectionProps);
    } else if (dbms.equals("mssql")) {

      Class.forName("net.sourceforge.jtds.jdbc.Driver");
      // jdbc:jtds:<server_type>://<server>[:<port>][/<database>][;<property>=<value>[;...]]
      // jdbc:jtds:sqlserver://MYPC:1433/Blog;instance=SQLEXPRESS;user=sa;password=s3cr3t
      conn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + serverName + ":" + portNumber + "/" + dbName, connectionProps);
    }
    System.out.println("Connected to database");
    isConnSetup = true;
    return conn;
  }

  public static List<String> getAllTables(String dbNamet) throws Exception {
    List<String> lista = new ArrayList<String>();
    dbName = dbNamet;
    try {
      if (motor.equals("mysql")) {
        Class.forName("com.mysql.jdbc.Driver");
      }
      DatabaseMetaData md = conn.getMetaData();
      String[] types = {"TABLE"};
      ResultSet rs = md.getTables(dbName, null, "%", types);

      logg.debug("Registros de tablas recuperados: " + rs.getRow());
      while (rs.next()) {
        lista.add(rs.getString(3));
      }
    } catch (Exception e) {
      e.printStackTrace();
      throw new Exception(e.getMessage());
    }
    return lista;
  }

  public static List<String> getAllDataBases() throws Exception {
    List<String> lista = new ArrayList<String>();
    try {
      if (motor.equals("mysql")) {
        Class.forName("com.mysql.jdbc.Driver");
      }
      ResultSet rs = conn.getMetaData().getCatalogs();

      while (rs.next()) {
        lista.add(rs.getString("TABLE_CAT"));
      }

    } catch (Exception e) {
      e.printStackTrace();
      throw new Exception(e.getMessage());
    }
    return lista;
  }

  public static List<String> getShemas(String db) throws Exception {
    List<String> lista = new ArrayList<String>();
    try {
      if (!motor.equals("mssql")) {

        DatabaseMetaData meta = conn.getMetaData();
        ResultSet schemas = meta.getSchemas(db, "%");
        String tableSchema = "";
        while (schemas.next()) {
          if (tableSchema != schemas.getString(1)) {
            tableSchema = schemas.getString(1); // "TABLE_SCHEM"
            // String tableCatalog = schemas.getString(2); //"TABLE_CATALOG"
            System.out.println("tableSchema" + tableSchema);

            lista.add(schemas.getString(1));
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      throw new Exception(e.getMessage());
    }
    return lista;
  }

  /**
   * Metodo recupera en List, porque esto es solo un ejemplo sencillo, si fuese produccion, lo mejor es retornar un objeto con los tipos de datos o el resulset original.
   * 
   * @param tabla
   * @return
   * @throws Exception
   */
  public static List<List<String>> getTableWithHead(String tabla) throws Exception {
    List<List<String>> lista = new ArrayList<List<String>>();
    // ResultSet rs = getInfoTable(dbName, tabla);
    ResultSet rs = getInfoTable(tabla);
    // agregando head
    System.out.println("Columnas Recuperadas : " + rs.getMetaData().getColumnCount());
    List<String> h = new ArrayList<String>();
    for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
      h.add(rs.getMetaData().getColumnName(i));
    }
    lista.add(h);

    while (rs.next()) {
      List<String> d = new ArrayList<String>();
      for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
        d.add(rs.getString(i));
      }
      lista.add(d);
    }
    return lista;
  }

  public static ResultSet getInfoTable(String tabla) throws Exception {
    int limite = 50;
    String lsQuery = "";
    if (motor.equals("mysql")) {
      lsQuery = "select * from " + tabla + " limit " + limite + "; ";
    } else if (motor.equals("mssql")) {
      lsQuery = "select top " + limite + " *  from " + tabla;
    } else if (motor.equals("postgres")) {
      lsQuery = "SELECT *   FROM \"" + tabla + "\"";
    } else {
      lsQuery = "select * from " + tabla + " limit " + limite + "; ";
    }
    System.out.println("SQL Ejecutada: " + lsQuery);
    ResultSet rs = ejecutaSelect(lsQuery);

    return rs;
  }

  public static List<String> getDatosTabla(String tabla) {
    List<String> lista = new ArrayList<String>();
    int limite = 50;

    return lista;
  }

  /**
   * Ejecuta un select
   * 
   * @parma lsQuery Consulta a ejecutar en mayusculas.
   */
  public static ResultSet ejecutaSelect(String lsQuery) throws Exception {
    try {

      DBConexion.abreConexionModoLectura();

      stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      // stmt = conBD.createStatement();
      ResultSet rs = stmt.executeQuery(lsQuery);
      return rs;
    } catch (SQLException sqlErr) {
      sqlErr.printStackTrace();
      System.out.println("Qurery:" + lsQuery);
      throw new Exception(sqlErr);
    } catch (Exception sqlErr) {
      sqlErr.printStackTrace();
      System.out.println("Qurery:" + lsQuery);
      throw new Exception(sqlErr);
    }
  }

  /**
   * Abre la conexion a la Base de Datos 1 TRANSACTION_READ_Commiteed; setReadOnly(true); setAutoCommit(TRUE);
   * 
   * @throws
   */
  public static void abreConexionModoLectura() throws Exception {
    try {
      // Parametros de la conexion
      conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
      conn.setReadOnly(true);
      conn.setAutoCommit(true);
      conn.setCatalog(dbName);

      stmtUp = conn.createStatement();

      isConnSetup = true;

    } catch (SQLException error) {
      System.out.println("SQL ERROR:  \tCLASE: CAccesoBD \n  TIPO: " + error.getMessage());
      throw new Exception("Exception: NO SE PUDO CONECTAR A LA BASE DE DATOS");
    } catch (Exception error) {
      throw new Exception(error);
    }
  }

  /**
   * Abre la conexion a la Base de Datos 3 TRANSACTION_READ_COMMITTED; setReadOnly(FALSE); setAutoCommit(FALSE);
   * 
   * PERMITE HACER CAMBIOS, ADD, DEL
   * 
   * @throws
   */
  public static void abreConexionModoEscrituraAutoCmmit() throws Exception {
    try {
      // Parametros de la conexion
      conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
      conn.setReadOnly(false);
      conn.setAutoCommit(true);
      // conn.setCatalog(dbName);

      stmtUp = conn.createStatement();

      isConnSetup = true;
    } catch (SQLException error) {
      System.out.println("SQL ERROR:  \tCLASE: CAccesoBD \n  TIPO: " + error.getMessage());
      throw new Exception("NO SE PUDO CONECTAR A LA BASE DE DATOS");
    } catch (Exception error) {
      error.printStackTrace();
      throw new Exception(error);
    }
  }

  /***************************************************************************************
   * EJECUTA UN QUERY ( INSERT, UPDATE O DELETE )
   ***************************************************************************************/

  /**
   * Ejecuta una modificacion (UPDATE, DELETE o INSERT)
   * 
   * @param lsQuery Query a ejecutar. @throws
   */
  public static int ejecutaSQL(String lsQuery) throws Exception, SQLException {
    int miNumRegModificados = 0;

    try {

      abreConexionModoEscrituraAutoCmmit();

      // stmtUp = conn.createStatement();
      miNumRegModificados = stmtUp.executeUpdate(lsQuery);

    } catch (Exception sqlErr) {
      throw new Exception(sqlErr);
    }
    return miNumRegModificados;

  }

  /**
   * 
   * @param tabla
   * @return
   * @throws SQLException
   */
  public static String getLlaveTabla(String DName, String tabla) throws SQLException {
    dbName = DName;
    String llave = "";
    DatabaseMetaData dmd = conn.getMetaData();
    ResultSet rs = dmd.getPrimaryKeys(dbName, null, tabla);

    while (rs.next()) {
      llave = rs.getString("COLUMN_NAME");
    }
    return llave;
  }

  public static void borraRegistro(String tabla, String filtro) throws SQLException, Exception {
    try {
      String cadena = "delete from " + tabla + " where " + filtro;
      System.out.println("SQL : " + cadena);
      ejecutaSQL(cadena);
    } catch (Exception e) {
      e.printStackTrace();
      throw new Exception(e.getMessage());
    }
  }

  public static void creaRegistro(String motor, String tabla, String campos, String tipos, String valores) throws SQLException, Exception {
    String cadena = "";
    // esta podria ser una cadena mas funcional, pero como estamos haciendo algo
    // generico, no funciona.
    // TODO corregir los tipos de datos.
    // parse rusticito para tipos string.
    logg.info("Valores de la variable tipos:" + tipos);
    if (motor.equals("postgres")) {
      cadena = "insert into \"" + tabla.trim() + "\" (" + campos.trim() + ") values (" + valores + ") ";
    } else {
      cadena = "insert into " + tabla.trim() + "(" + campos + ") values (" + valores + ") ";
    }

    System.out.print("SQLInsert: " + cadena);
    ejecutaSQL(cadena);
  }

  public static void modRecord() throws SQLException, Exception {

  }

}
