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
char def_farbe[7] ="ffffff" ;
int anz_threads = 1;
#define DATA_MAX 1000000
#define TEMP_MAX 100
int breite=5;
int laenge = 1000;

void *Thread(){
	int sock = socket(AF_INET, SOCK_STREAM,0);
	struct sockaddr_in server_data;
	server_data.sin_family = AF_INET;//Addressfamilie
	server_data.sin_port = htons(port);//Portnummer
	server_data.sin_addr.s_addr = inet_addr(ip);//IP-Adresse
	int max = 16777215;
	int anf_x;
	int anf_y;
	int ri_wechsel=0;
	int richtung=0;
	int unten;
	int oben;
	int rechts;
	int links;
	char data[DATA_MAX]="\n";
	char tmp[TEMP_MAX]="\n";

	int farbe1=0;
	int farbe2=0;
	srand(time(NULL));

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
			anf_x=rand()%max_x;
			anf_y=rand()%max_y;
			links=0;
			rechts=0;
			oben=0;
			unten=0;
			for(long int i=0;i<=laenge;i++){
				if(i%2==0){
					ri_wechsel = rand()%10;
					if(ri_wechsel<=1){
						richtung = rand()%4;
					}
				}
				farbe1 = rand()%max;
				farbe2 = rand()%max;
				int diff_uo=unten-oben;
		  		int diff_rl=rechts-links;
				//sprintf(data, "HELP\n");
				//send(sock, data, strlen(data), 0);
				for(int j=1;j<breite; j++){
					if(richtung==0){
						unten = unten +1;
						diff_uo=unten-oben;
						diff_rl=rechts-links;
						sprintf(tmp,"PX %i %i %x\n",anf_x+diff_uo,anf_y+diff_rl+j,farbe1);
						strcat(data,tmp);
						sprintf(tmp,"PX %i %i %x\n",anf_x+diff_uo,anf_y+diff_rl-j,farbe2);
						strcat(data,tmp);
						sprintf(tmp,"PX %i %i %s\n",anf_x+diff_uo,anf_y+diff_rl+breite,def_farbe);
						strcat(data,tmp);
						sprintf(tmp,"PX %i %i %s\n",anf_x+diff_uo,anf_y+diff_rl-breite,def_farbe);
						strcat(data,tmp);
					}
	        			if(richtung==1){
						oben = oben +1;
						diff_uo=unten-oben;
						diff_rl=rechts-links;
					        sprintf(tmp,"PX %i %i %x\n",anf_x+diff_uo,anf_y+diff_rl+j,farbe2);
						strcat(data,tmp);
					        sprintf(tmp,"PX %i %i %x\n",anf_x+diff_uo,anf_y+diff_rl-j,farbe1);
						strcat(data,tmp);
					        sprintf(tmp,"PX %i %i %s\n",anf_x+diff_uo,anf_y+diff_rl+breite,def_farbe);
						strcat(data,tmp);
					        sprintf(tmp,"PX %i %i %s\n",anf_x+diff_uo,anf_y+diff_rl-breite,def_farbe);
						strcat(data,tmp);
				        }
				      	if(richtung==2){
						links = links +1;
						diff_uo=unten-oben;
						diff_rl=rechts-links;
	        				sprintf(tmp,"PX %i %i %x\n",anf_x+diff_uo+j,anf_y+diff_rl,farbe1);
						strcat(data,tmp);
						sprintf(tmp,"PX %i %i %x\n",anf_x+diff_uo-j,anf_y+diff_rl,farbe2);
						strcat(data,tmp);
		      				sprintf(data,"PX %i %i %s\n",anf_x+diff_uo+breite,anf_y+diff_rl,def_farbe);
						strcat(data,tmp);
	        				sprintf(data,"PX %i %i %s\n",anf_x+diff_uo-breite,anf_y+diff_rl,def_farbe);
						strcat(data,tmp);
	      				}
				        if(richtung==3){
						rechts = rechts +1;
						diff_uo=unten-oben;
						diff_rl=rechts-links;
					        sprintf(tmp,"PX %i %i %x\n",anf_x+diff_uo+j,anf_y+diff_rl,farbe2);
						strcat(data,tmp);
				        	sprintf(tmp,"PX %i %i %x\n",anf_x+diff_uo-j,anf_y+diff_rl,farbe1);
						strcat(data,tmp);
	        				sprintf(tmp,"PX %i %i %s\n",anf_x+diff_uo+breite,anf_y+diff_rl,def_farbe);
						strcat(data,tmp);
	        				sprintf(tmp,"PX %i %i %s\n",anf_x+diff_uo-breite,anf_y+diff_rl,def_farbe);
						strcat(data,tmp);
	        			}
				}
				diff_uo=unten-oben;
	    			diff_rl=rechts-links;
				sprintf(tmp,"PX %i %i %s\n",anf_x+diff_uo,anf_y+diff_rl,def_farbe);
				strcat(data,tmp);
				if(i%100){
					send(sock, data, strlen(data), 0);
					data[0]='\0';
					sprintf(data,"\n");
				}
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
