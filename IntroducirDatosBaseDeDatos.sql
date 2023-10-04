#include <mysql.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
int main(int argc, char **argv) 
{
	MYSQL *conn;
	int err;
	char nombre[25];
	int edad;
	char edads[3];
	char codigo[10];
	char contrasena[10];
	int i;
	char consulta[80];
conn = mysql_init(NULL);
if(conn==NULL)
{
	printf ("Error al crear la conexion: %u %s\n",
	mysql_errno(conn), mysql_error(conn));
	exit(1);
}
conn = mysql_real_connect (conn, "localhost","root", "mysql", "jugadores",0, NULL,0);
if(conn==NULL)
{
	printf ("Error al inicializar la conexion: %u %s\n",
	mysql_errno(conn),mysql_error(conn));
	exit(1);
}
for(i=0;i<4;i++)
{
	printf("Escribe el nombre, codigo identificativo, edad, contrasena, separados por un blanco\n");
	err = scanf ("%s %s %d %s", nombre, codigo, &edad, contrasena);
	if (err!=4)
	{
		printf ("Error al introducir los datos\n");
		exit(1);
	}
strcpy (consulta, "INSERT INTO personas VALUES ('");
	strcat(consulta, nombre);
	strcat(consulta, "','");
	strcat(consulta, codigo);
	strcat(consulta, "','");
	sprintf(edads, "%d", edad);
	strcat(consulta, edads);
	strcat(consulta, "','");
	strcat(consulta, contrasena);
	strcat(consulta, "');");
	
	printf("consulta = %s\n", consulta);
	err = mysql_query(conn, consulta);
	if (err!=0)
	{
		printf ("Error al introducir datos a la base %u %s\n",
		mysql_errno(conn), mysql_error(conn));
		exit(1);
	}
}
mysql_close(conn);
exit(0);
}

