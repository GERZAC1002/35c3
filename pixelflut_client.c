/*
Copyright (C) [2019]  [Gernot Zacharias]

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <string.h>
#include <unistd.h>

unsigned short int port = 80;
char ip[100]="151.217.40.82";
int farbe = 100000;
int offset_x =300;
int offset_y = 300;
int bild_hohe = 100;
int bild_breite = 100;
int hohe = 1080;
int breite = 1920;

int main(int argc, char *argv[]){
	if(argc < 3){
		printf("Kommandozeilen Parameter: <programm> <IP-Adresse> <Port> <Threads>\n");
		printf("Eingabe IPv4:");
		scanf("%s",ip);
		printf("Eingabe Port:");
		scanf("%d",&port);
	}else{
		port=atoi(argv[2]);
		for(int i=0;i<16;i++){
			ip[i] = argv[1][i];
		}
	}
	int sock = socket(AF_INET, SOCK_STREAM,0);
	srand(time(NULL));
	struct sockaddr_in server_data;
	server_data.sin_family = AF_INET;//Addressfamilie
	server_data.sin_port = htons(port);//Portnummer
	server_data.sin_addr.s_addr = inet_addr(ip);//IP-Adresse

	if(sock < 0){
		printf("Fehler beim Erzeugen des Sockets\n");
	}else{
		if (connect(sock,(struct sockaddr*)&server_data, sizeof(server_data)) < 0){
      	 		printf("Fehler beim herstellen der Verbindung\n");
		}else{
			while(1){
			        offset_x=rand()%(breite-bild_breite);
			        offset_y=rand()%(hohe-bild_hohe);
				for(int x=0; x <= bild_hohe;x++){
					for(int y=0; y <= bild_breite; y++){
						char data[100]="\n";
						sprintf(data, "PX %i %i %X\n",x+offset_x,y+offset_y,farbe);
						send(sock, data, strlen(data), 0);
					}
				}
			}
		}
	}
}
