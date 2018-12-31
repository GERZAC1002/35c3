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
int farbe = 100000;
int offset_x =300;
int offset_y = 300;
int bild_hohe = 100;
int bild_breite = 100;
int hohe = 1080;
int breite = 1920;

int main(int argc, char *argv[]){
	int sock = socket(AF_INET, SOCK_STREAM,0);
	port = atoi(argv[2]);
	srand(time(NULL));
	struct sockaddr_in server_data;
	server_data.sin_family = AF_INET;//Addressfamilie
	server_data.sin_port = htons(port);//Portnummer
	server_data.sin_addr.s_addr = inet_addr(argv[1]);//IP-Adresse

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