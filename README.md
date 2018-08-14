# Simple JAVA CRUD 
JSP + algunos motores de DB (MySQL, postgresql, etc)

Cada x punto en la línea del tiempo, alguien quiere iniciarse en el mundo JAVA y crear alguna aplicación web dinámica, he creo esto con el objetivo de darles algo con que iniciar; espero sea de ayuda.


**Características:**
- Pure HTML, JavaScript, DHTML.
- No FrameWork,
- POO no bien implementada, mas POP(procedimientos) para agilizar el desarrollo.
- Soporte a Multi Motores de base de datos: H2, sqlite, mysql, SQLServer y postgres.
- Automatizacion con Maven

# OBJETIVOS
Libre, pedagócigo, facil, entendible, básico, from scratch.


# STACK

html
javascript
jdbc
pojo
maven


# COMO PROBAR

Obetener el codigo usando  git. 

*git clone https://github.com/berroteran/java_simple_crud.git*


## Comandos maven
Compilar

*mvn compile*

Crear el WAR

*mvn package*  or *mvn war:war*





## comandos maven para probar directamente.

### Tomcat 6
 
  *mvn -U tomcat8:run*

### tomcat 7
 
  *mvn -U tomcat7:run*

### tomact 8

  mvn -U tomcat8:run

### Payara Micro (la version de payara para microservicios)

  *mvn clean install payara-micro:bundle payara-micro:start*




# Licencia
M.I.T. /  CC by



# Disclamer
