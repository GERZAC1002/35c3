/*
Copyright (C) [2019]  [Gernot Zacharias]

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <string.h>
#include <unistd.h>

#define HOHE 800
#define BREITE 1280

char data[HOHE+BREITE+20];
char ip[100]="127.0.0.1";
int port = 1234;

int main(int argc, char *argv[]){
	char *data_r;
	data_r = malloc(21*sizeof(char *));
	if(argc < 3){
		printf("Kommandozeilen Parameter: <programm> <IP-Adresse> <Port>\n");
		printf("Eingabe IPv4:");
		scanf("%s",ip);
		printf("Eingabe Port:");
		scanf("%d",&port);
	}else{
		port=atoi(argv[2]);
		for(int i=0;i<16;i++){
			ip[i] = argv[1][i];
		}
	};
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
			for(int x = 0;x <= BREITE-1;x++){
				for(int y = 0;y <= HOHE-1;y++){
					char tmp[14];
					sprintf(tmp,"PX %i %i\n",x,y);
					strcat(data,tmp);
					if(send(sock, data, strlen(data), 0)){
						if(recv(sock, data_r, sizeof(data_r),0) > 0){
							printf("%s",data_r);
							data_r[0]=NULL;
						}
					}
					data[0] = '\0';
					sprintf(data, "\n");
				}
			}
			while(recv(sock, data_r, sizeof(data_r),0) > 0){
				printf("%s",data_r);
				data_r[0]=NULL;
			}
			free(data_r);
			printf("\nProgrammende!\n");
			close(sock);
			return 0;
		}
	}
}
