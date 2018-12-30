#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int zufall = 0; //Ändern um Pixel zufällige Farben zugeben
char farbe[10] = "00ff00"; //Pixel Farbe festlegen
int offset_x=200;
int offset_y=1170;


int main(){
	while(1){
	int matrix[1000][1000] ={ 	
		{1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 0,1, 0, 0, 0,1, 0, 1, 0,0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{1, 1, 1, 0,1, 1, 1, 0,1, 0, 0, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 0,0, 0, 1, 0,1, 0, 1, 0,0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0,1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		/*{1, 0, 1, 0, 1, 0, 0,1, 0, 1, 0,0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0 ,1},
		{1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0},
		{1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0},
		{1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0},
		{1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0}*/
	};
	srand(time(NULL));
	for(int x=1;x<=250;x++){
		for(int y=1;y<=750;y++){
			if(matrix[x/50][y/50]==1){
				if(zufall == 1){
					int random_rot_1=rand()%9;
				        int random_rot_2=rand()%9;
				        int random_gruen_1=rand()%9;
				        int random_gruen_2=rand()%9;
			        	int random_blau_1=rand()%9;
				        int random_blau_2=rand()%9;
					printf("PX %i %i %i%i%i%i%i%i\n",x+offset_x,y+offset_y,random_rot_1,random_rot_2,random_gruen_1,random_gruen_2,random_blau_1,random_blau_2);
				}else{
					printf("PX %i %i %s\n",y+offset_y,x+offset_x,farbe);
				}
			}else{
				printf("PX %i %i 000000\n",y+offset_y,x+offset_x);
			}
		}
	}
	}
	exit(0);
}
