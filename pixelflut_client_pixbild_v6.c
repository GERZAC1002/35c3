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
#include <signal.h>

int port=1234;
char ip[100] = "151.217.40.82";
int g = 1;
int  max_x = 1920;
int  max_y = 1080;
int  bild_hohe =  100;
int  bild_breite = 300;
char def_farbe[10] ="ff00" ;
int anz_threads = 1;
#define DATA_MAX 1000000
#define TEMP_MAX 100
int offset_x;
int offset_y;
long int zeit1 = 0;

void *Thread(void *tid){
	bild_hohe = bild_hohe * g;
	bild_breite = bild_breite * g;
	int sock = socket(AF_INET6, SOCK_STREAM,IPPROTO_TCP);
        struct sockaddr_in6 server_data;
        server_data.sin6_family = AF_INET6;//Addressfamilie
        server_data.sin6_port = htons(port);//Portnummer
        //server_data.sin6_addr.s_addr = inet_addr(ip);//IP-Adresse
        inet_pton(AF_INET6,ip, &server_data.sin6_addr);
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
		const int matrix[1000][1000] ={
			{1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 1, 0,1, 0, 0, 0,1, 0, 1, 0,0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{1, 1, 1, 0,1, 1, 1, 0,1, 0, 0, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 1, 0,1, 0, 1, 0,1, 0, 1, 0,0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		};
		while(1){
			if(tid == 0 && ((zeit1+10) < time(NULL))){
				zeit1 = time(NULL);
				srand(time(NULL));
				unsigned char rot = rand()%255;
				unsigned char grun = rand()%255;
				unsigned char blau = rand()%255;
                                sprintf(def_farbe,"%02X%02X%02X\0",rot,grun,blau);
                                printf("Rot:%d, Grun:%d, Blau:%d, hex:%s\n",rot,grun,blau,def_farbe);
                        }
			for(int x=0;x<=bild_breite;x++){
				for(int y=0;y<=bild_hohe;y++){
					if(matrix[y/(20*g)][x/(20*g)]==1){
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
	signal(SIGPIPE, SIG_IGN);
	if(argc < 6){
		printf("Kommandozeilen Parameter: <programm> <IP-Adresse> <Port> <Threads>\n");
		printf("Eingabe IPv4:");
		scanf("%s",ip);
		printf("Eingabe Port:");
		scanf("%d",&port);
		printf("Anzahl Threads:");
		scanf("%d",&anz_threads);
		printf("Eingabe Position x:");
		scanf("%d",&max_x);
		max_x = max_x + bild_breite;
		printf("Eingabe Position y:");
		scanf("%d",&max_y);
		max_y = max_y + bild_hohe;
	}else{
		port=atoi(argv[2]);
		anz_threads=atoi(argv[3]);
		int i = 0;
		while(argv[1][i]>0){
                        ip[i] = argv[1][i];
                        i++;
                }
		max_x = atoi(argv[4]);
		max_y = atoi(argv[5]);
		max_x = max_x + bild_breite;
		max_y = max_y + bild_hohe;
	}
	printf("ip:%s port:%d threads:%d x:%d y:%d\n",ip,port,anz_threads,max_x,max_y);
	offset_x = max_x - bild_breite;
	offset_y = max_y - bild_hohe;
	pthread_t threads[anz_threads];
	for (int i = 0; i < anz_threads; i++){
  	pthread_create(&threads[i], NULL, Thread, (void *)i);
	}
	pthread_exit(NULL);
	return 0;
}
