#include <mysql.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
int main(int argc, char **argv) 
{
MYSQL *conn;
int err;
MYSQL_RES *resultado;
MYSQL_ROW row;
int id;
char ids[3];
char codigo[10];
char consulta[80];
conn = mysql_init(NULL);
    if(conn==NULL)
	{
		printf ("Error al crear la conexion: %u %s\n",
		mysql_errno(conn), mysql_error(conn));
		exit(1);
	}
conn = mysql_real_connect (conn, "localhost", "root", "mysql", "jugadores",0, NULL,0);
    if (conn==NULL)
	{
		printf ("Error al inicializar la conexion: %u %s\n",
		mysql_errno(conn), mysql_error(conn));
		exit(1);
	}
err = mysql_query (conn, "SELECT * FROM personas");
	if (err!=0)
	{
		printf ("Error al consultar datos de la base de datos %u %s\n",
		mysql_errno(conn), mysql_error(conn));
		exit(1);
	}
resultado = mysql_store_result(conn);
row =mysql_fetch_row(resultado);
    if (row==NULL)
		printf ("NO se han obtenido datos en la consulta\n");
	else
		while(row!=NULL)
	{
		id = atoi (row[0]);
		printf ("ID: %d, codigo: %s\n", id, row[1]);
		row = mysql_fetch_row(resultado);
	}
printf ("Dame el id de las partidas jugadas\n");
scanf ("%d", &id);
strcpy (consulta, "SELECT codigo FROM partidas_jugadas WHERE id ='");
sprintf(ids, "%d", id);
strcat(consulta, ids);
strcat(consulta, "'");
err = mysql_query (conn, consulta);
    if (err!=0)
	{
		printf ("Error al consultar datos de la base de datos %u %s\n",
		mysql_errno(conn), mysql_error(conn));
		exit(1);
	}
resultado = mysql_store_result(conn);
row = mysql_fetch_row(resultado);
    if (row==NULL)
		printf ("No se han obtenido datos en la consulta\n");
	else
		printf ("Codigo de la persona: %s\n", row[0]);
mysql_close(conn);
exit(0);
}

