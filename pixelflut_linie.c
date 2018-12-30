#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <unistd.h>

long int laenge = 1000000000000;
int max = 16777215;
int anf_x = 500;
int anf_y = 500;
int breite = 10;

int ri_wechsel=0;
int richtung=0;
int oben=0;
int unten=0;
int links=0;
int rechts=0;

int farbe=0;

int main(){
	srand(time(NULL));
	while(1){
		links = 0;
		rechts = 0;
		oben = 0;
		unten = 0;
		anf_x = rand()%1000;
		anf_y = rand()%1000;
		printf("PX %i %i %X",anf_x,anf_y,farbe);
		for(long int i=0;i<=1000;i++){
			ri_wechsel = rand()%10;
			if(ri_wechsel<=1){
				richtung = rand()%4;
			}
			farbe = rand()%max;
			if(richtung==0){
				rechts = rechts +1;
			}
			if(richtung==1){
				unten = unten +1;
			}
			if(richtung==2){
				links = links +1;
			}
			if(richtung==3){
				oben = oben +1;
			}
			printf("PX %i %i %X\n", anf_x+unten-oben,anf_y+rechts-links,farbe);
			for(int j=0;j<breite; j++){
				printf("PX %i %i %X\n", anf_x+unten-oben+j,anf_y+rechts-links+j,farbe);
				printf("PX %i %i %X\n", anf_x+unten-oben-j,anf_y+rechts-links-j,farbe);
				printf("PX %i %i %X\n", anf_x+unten-oben-j,anf_y+rechts-links+j,farbe);
				printf("PX %i %i %X\n", anf_x+unten-oben+j,anf_y+rechts-links-j,farbe);
				printf("PX %i %i %X\n", anf_x+unten-oben,anf_y+rechts-links+j,farbe);
                                printf("PX %i %i %X\n", anf_x+unten-oben,anf_y+rechts-links-j,farbe);
                                printf("PX %i %i %X\n", anf_x+unten-oben-j,anf_y+rechts-links,farbe);
                                printf("PX %i %i %X\n", anf_x+unten-oben+j,anf_y+rechts-links,farbe);
			}
		}
		sleep(1);
	}
	exit(0);
}
