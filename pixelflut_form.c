#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <unistd.h>

long int laenge = 1000000000000;
int max = 16777215;
int anf_x = 500;
int anf_y = 500;
int breite = 4;

int ri_wechsel=0;
int richtung=0;
int unten;
int oben;
int rechts;
int links;

int farbe1=0;
int farbe2=0;

int main(){
	srand(time(NULL));
	while(1){
		anf_x=rand()%1000;
		anf_y=rand()%1000;
		links=0;
		rechts=0;
		oben=0;
		unten=0;
		for(long int i=0;i<=1000;i++){
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
			for(int j=1;j<breite; j++){
				if(richtung==0){
					unten = unten +1;
					diff_uo=unten-oben;
					diff_rl=rechts-links;
					printf("PX %i %i %X\n",anf_x+diff_uo,anf_y+diff_rl+j,farbe1);	
					printf("PX %i %i %X\n",anf_x+diff_uo,anf_y+diff_rl-j,farbe2);
					printf("PX %i %i FFFFFF\n",anf_x+diff_uo,anf_y+diff_rl+breite);
                                        printf("PX %i %i FFFFFF\n",anf_x+diff_uo,anf_y+diff_rl-breite);
                        	}	
	                        if(richtung==1){
					oben = oben +1;
					diff_uo=unten-oben;
					diff_rl=rechts-links;
                                        printf("PX %i %i %X\n",anf_x+diff_uo,anf_y+diff_rl+j,farbe2);
                                        printf("PX %i %i %X\n",anf_x+diff_uo,anf_y+diff_rl-j,farbe1);
                                        printf("PX %i %i FFFFFF\n",anf_x+diff_uo,anf_y+diff_rl+breite);
                                        printf("PX %i %i FFFFFF\n",anf_x+diff_uo,anf_y+diff_rl-breite);
        	                }
                	        if(richtung==2){
					links = links +1;
					diff_uo=unten-oben;
					diff_rl=rechts-links;
                                        printf("PX %i %i %X\n",anf_x+diff_uo+j,anf_y+diff_rl,farbe1);
                                        printf("PX %i %i %X\n",anf_x+diff_uo-j,anf_y+diff_rl,farbe2);
                                        printf("PX %i %i FFFFFF\n",anf_x+diff_uo+breite,anf_y+diff_rl);
                                        printf("PX %i %i FFFFFF\n",anf_x+diff_uo-breite,anf_y+diff_rl);
                        	}
	                        if(richtung==3){
					rechts = rechts +1;
					diff_uo=unten-oben;
					diff_rl=rechts-links;
                                        printf("PX %i %i %X\n",anf_x+diff_uo+j,anf_y+diff_rl,farbe2);
                                        printf("PX %i %i %X\n",anf_x+diff_uo-j,anf_y+diff_rl,farbe1);
                                        printf("PX %i %i FFFFFF\n",anf_x+diff_uo+breite,anf_y+diff_rl);
                                        printf("PX %i %i FFFFFF\n",anf_x+diff_uo-breite,anf_y+diff_rl);
        	                }
			}
			diff_uo=unten-oben;
                        diff_rl=rechts-links;
			printf("PX %i %i FFFFFF\n",anf_x+diff_uo,anf_y+diff_rl);
			if(richtung==0){
				for(int z=1;z<=breite;z++){
					
				}
			}			
		}
		//sleep(1);
	}
	exit(0);
}
