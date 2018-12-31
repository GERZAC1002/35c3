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
int max_x = 1920;
int max_y = 1080;
char def_farbe[7] ="0" ;
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
			for(int x=0;x<=max_x;x++){
				for(int y=0;y<=max_y;y++){
					sprintf(tmp,"PX %i %i %s\n",x,y,def_farbe);
					strcat(data,tmp);
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