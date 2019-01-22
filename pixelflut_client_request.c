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

#define HOHE 1080
#define BREITE 1980
#define PORT 1234

char data[HOHE*BREITE*15];

int main(int argc, char *argv[]){
	int sock = socket(AF_INET, SOCK_STREAM,0);
	//port = atoi(argv[2]);
	srand(time(NULL));
	struct sockaddr_in server_data;
	server_data.sin_family = AF_INET;//Addressfamilie
	server_data.sin_port = htons(PORT);//Portnummer
	server_data.sin_addr.s_addr = inet_addr(argv[1]);//IP-Adresse

	if(sock < 0){
		printf("Fehler beim Erzeugen des Sockets\n");
	}else{
		if (connect(sock,(struct sockaddr*)&server_data, sizeof(server_data)) < 0){
      	 		printf("Fehler beim herstellen der Verbindung\n");
		}else{
			for(int x = 0;x < BREITE;x++){
				for(int y = 0;y < HOHE;y++){
					sprintf(data,"PX %i %i\n",x,y);
				}
			}
			while(1){
				send(sock, data, strlen(data), 0);
				sleep(60);
			}
		}
	}
}