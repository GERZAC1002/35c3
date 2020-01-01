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

#include "zahlen.h"

char matrix[9][30];

int anzeige_zahl(char text[9][5],int durch,char zahl){
	for(int i = 0; i < 5 ; i++){
		if(text[durch][i] == '#'){
			matrix[durch][i+(zahl*6)] = 1;
		}else{
			matrix[durch][i+(zahl*6)] = 0;
		}
	}
	matrix[durch][6+(zahl*6)] = 0;
	return 0;
}

int zeige_zahl(int i,int durch,char zahl){
	if(i == 0){
		anzeige_zahl(nul,durch,zahl);
	}
	if(i == 1){
		anzeige_zahl(eins,durch,zahl);
	}
	if(i == 2){
		anzeige_zahl(zwei,durch,zahl);
	}
	if(i == 3){
		anzeige_zahl(drei,durch,zahl);
	}
	if(i == 4){
		anzeige_zahl(vier,durch,zahl);
	}
	if(i == 5){
		anzeige_zahl(funf,durch,zahl);
	}
	if(i == 6){
		anzeige_zahl(sechs,durch,zahl);
	}
	if(i == 7){
		anzeige_zahl(sieben,durch,zahl);
	}
	if(i == 8){
		anzeige_zahl(acht,durch,zahl);
	}
	if(i == 9){
		anzeige_zahl(neun,durch,zahl);
	}
	if(i == 98){
		anzeige_zahl(leer,durch,zahl);
	}
	if(i == 99){
		anzeige_zahl(dp,durch,zahl);
	}
	return 0;
}

int port=1234;
char ip[100] = "151.217.40.82";
int g = 1;
int  max_x = 1920;
int  max_y = 1080;
int  bild_hohe =  135;
int  bild_breite = 450;
char def_farbe[10] ="ff0000" ;
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
		long int zeit = 0;
		while(1){
			/*if(tid == 0 && ((zeit1+10) < time(NULL))){
				zeit1 = time(NULL);
				srand(time(NULL));
				unsigned char rot = rand()%255;
				unsigned char grun = rand()%255;
				unsigned char blau = rand()%255;
                                sprintf(def_farbe,"%02X%02X%02X\0",rot,grun,blau);
                                printf("Rot:%d, Grun:%d, Blau:%d, hex:%s\n",rot,grun,blau,def_farbe);
                        }*/
			if(tid == 0 && ((zeit+10) < time(NULL))){
				zeit = time(NULL);
				srand(time(NULL));
				unsigned char rot = rand()%255;
				unsigned char grun = rand()%255;
				unsigned char blau = rand()%255;
                                sprintf(def_farbe,"%02X%02X%02X\0",rot,grun,blau);
                                printf("Rot:%d, Grun:%d, Blau:%d, hex:%s\n",rot,grun,blau,def_farbe);
                        }
			zeit1 = time(NULL);
			zeit1 = zeit1 + (60*60*1);
			int stunde,minute = 0;
			minute = zeit1 % 3600 / 60;
			stunde = zeit1 % 86400 / 3600;
			int s1,s2,m1,m2 = 0;
			s1 = stunde % 10;
			s2 = stunde / 10;
			m1 = minute % 10;
			m2 = minute / 10;
			for(int i = 0; i < 9; i++){
				zeige_zahl(s2,i,0);
				zeige_zahl(s1,i,1);
				zeige_zahl(99,i,2);
				zeige_zahl(m2,i,3);
				zeige_zahl(m1,i,4);
			}
			for(int x=0;x<=bild_breite;x++){
				for(int y=0;y<=bild_hohe;y++){
					if(matrix[y/(15*g)][x/(15*g)]==1){
						sprintf(tmp,"PX %i %i %s\n",x+offset_x,y+offset_y,def_farbe);
						strcat(data,tmp);
					}else{
					//	sprintf(tmp,"PX %i %i 0\n",x+offset_x,y+offset_y);
					//	strcat(data,tmp);
					}
				}
				send(sock, data, strlen(data), 0);
				data[0]='\0';
				sprintf(data,"\n");
			}
			/*for(int y=0;y<9;y++){
				for(int x=0;x<30;x++){
					if(matrix[y][x] == 1){
						printf("#");
					}else{
						printf("0");
					}
				}
				printf("\n");
			}
			printf("\n");
			*/
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
