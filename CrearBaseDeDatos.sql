#include <mysql.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
int main(int argc, char **argv) 
{
MYSQL *conn;
int err;
conn = mysql_init(NULL);
if(conn==NULL)
{
	printf("Error al crear la conexion:%u%s\n",
    mysql_errno(conn), mysql_error(conn));
	exit(1);
}
conn = mysql_real_connect (conn,"localhost","root","mysql",NULL, 0, NULL, 0);
if(conn==NULL)
{
	printf("Error al inicializar la conexion:%u%s\n",
	mysql_errno(conn), mysql_error(conn));
	exit(1);
}
mysql_query(conn, "drop database if exists jugadores;");
err=mysql_query(conn, "create database jugadores;");
if(err!=0)
{
	printf("Error al crear la base de datos %u %s\n",
	mysql_errno(conn), mysql_error(conn));
	exit(1);
}
err=mysql_query(conn, "use jugadores;");
if(err!=0)
{
	printf("Error al crear la base de datos %u %s\n",
	mysql_errno(conn), mysql_error(conn));
	exit(1);
}
err=mysql_query(conn, "CREATE TABLE personas (codigo VARCHAR(10) not null primary key, nombre VARCHAR(25), edad int, contraseña VARCHAR(10))");
if(err!=0)
{
	printf("Error al definir la tabla %u %s\n",
	mysql_errno(conn), mysql_error(conn));
	exit(1);
}
err=mysql_query(conn, "CREATE TABLE partida (id int, fecha date, hora time)");
if(err!=0)
{
	printf("Error al definir la tabla %u %s\n",
		   mysql_errno(conn), mysql_error(conn));
	exit(1);
}
err=mysql_query(conn, "CREATE TABLE partidas_jugadas (id int, codigo VARCHAR(10) not null primary key)");
if(err!=0)
{
	printf("Error al definir la tabla %u %s\n",
		   mysql_errno(conn), mysql_error(conn));
	exit(1);
}
mysql_close(conn);
exit(0);
}

