#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main(){
	while(1){
		for(int x=1;x<=1920;x++){
			for(int y=1;y<=1080;y++){
				printf("PX %i %i 000000\n",x,y);
			}
		}
	}
	exit(0);
}
