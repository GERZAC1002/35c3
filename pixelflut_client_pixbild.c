/*
Copyright (C) [2019]  [Gernot Zacharias]

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <string.h>
#include <pthread.h>

int port=1234;
char ip[100]="151.217.40.82";
#define  max_x 1920
#define  max_y 1080
#define  bild_hohe  250
#define  bild_breite  750
int offset_x = max_x-bild_breite;
int offset_y = max_y-bild_hohe;
char def_farbe[7] ="ff00" ;
int anz_threads = 1;
#define DATA_MAX 1000000
#define TEMP_MAX 100

void *Thread(){
	int sock = socket(AF_INET, SOCK_STREAM,0);
	struct sockaddr_in server_data;
	server_data.sin_family = AF_INET;//Addressfamilie
	server_data.sin_port = htons(port);//Portnummer
	server_data.sin_addr.s_addr = inet_addr(ip);//IP-Adresse
	char data[DATA_MAX]="\n";
	char tmp[TEMP_MAX]="\n";
	if(sock < 0){
		printf("Fehler beim Erzeugen des Sockets\n");
		exit(-1);
	}else{
		if (connect(sock,(struct sockaddr*)&server_data, sizeof(server_data)) < 0){
      	 		printf("Fehler beim herstellen der Verbindung\n");
		}else{
			printf("Verbindung hergestellt\n");
		}
		while(1){
		        int matrix[1000][1000] ={
        	        	{1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		                {0, 0, 1, 0,1, 0, 0, 0,1, 0, 1, 0,0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        		        {1, 1, 1, 0,1, 1, 1, 0,1, 0, 0, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        	        	{0, 0, 1, 0,0, 0, 1, 0,1, 0, 1, 0,0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		                {1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		        };
	        	for(int x=0;x<=bild_breite;x++){
        	        	for(int y=0;y<=bild_hohe;y++){
                	        	if(matrix[y/50][x/50]==1){
						sprintf(tmp,"PX %i %i %s\n",x+offset_x,y+offset_y,def_farbe);
						strcat(data,tmp);
        	                        }else{
						sprintf(tmp,"PX %i %i 0\n",x+offset_x,y+offset_y);
						strcat(data,tmp);
					}
	                        }
				send(sock, data, strlen(data), 0);
				data[0]='\0';
				sprintf(data,"\n");
			}
		}
	}
	exit(0);
}

int main(int argc, char *argv[]){
	int i;
	port=atoi(argv[2]);
	anz_threads=atoi(argv[3]);
	for(int i=0;i<16;i++){
		ip[i] = argv[1][i];
	}
	pthread_t tid;
	for (i = 0; i < anz_threads; i++){
  	pthread_create(&tid, NULL, Thread, (void *)&tid);
	}
	pthread_exit(NULL);
	return 0;
}
