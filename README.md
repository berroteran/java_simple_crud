# Simple JAVA CRUD 
JSP + algunos motores de DB (MySQL, postgresql, etc)

Cada x punto en la línea del tiempo, alguien quiere iniciarse en el mundo JAVA y crear alguna aplicación web dinámica, he creado esto con el objetivo de darles algo con que iniciar; espero sea de ayuda.


**Características:**
- Pure HTML, JavaScript, DHTML.
- No FrameWork.
- No Hibernate.
- POO no bien implementada, mas POP(procedimientos) para agilizar el desarrollo.
- Soporte a Multi Motores de base de datos: H2, sqlite, mysql, SQLServer y postgres.
- Automatizacion con Maven.

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





## Comandos maven para probar directamente.


### tomcat 7
 
  *mvn -U tomcat7:run-war*

### tomact 8

  *mvn -U tomcat8:run-war*

### Payara Micro (la version de payara para microservicios)

 En 2 pasos: 
  
  *mvn payara-micro:bundle*  Construye
 
  *mvn payara-micro:start*

  *mvn clean install payara-micro:bundle payara-micro:start*
  
 Limpiar, compilar, instalar e iniciar.
 
  *mvn clean compile install payara-micro:bundle payara-micro:start*




# Licencia
M.I.T. /  CC by

Autor:
Omar Berroterán


# Dissclamer
