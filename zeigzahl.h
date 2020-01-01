#include "zahlen.h"

int anzeige_zahl(char text[9][5],int durch,char ersatz){
	for(int i = 0; i < 5 ; i++){
		if(text[durch][i] == '#'){
			printf("%c ",ersatz);
		}else{
			printf("%c ",' ');
		}
	}
	printf(" ");
	return 0;
}

int zeige_zahl(int i,int durch,char ersatz){
	if(i == 0){
		anzeige_zahl(nul,durch,ersatz);
	}
	if(i == 1){
		anzeige_zahl(eins,durch,ersatz);
	}
	if(i == 2){
		anzeige_zahl(zwei,durch,ersatz);
	}
	if(i == 3){
		anzeige_zahl(drei,durch,ersatz);
	}
	if(i == 4){
		anzeige_zahl(vier,durch,ersatz);
	}
	if(i == 5){
		anzeige_zahl(funf,durch,ersatz);
	}
	if(i == 6){
		anzeige_zahl(sechs,durch,ersatz);
	}
	if(i == 7){
		anzeige_zahl(sieben,durch,ersatz);
	}
	if(i == 8){
		anzeige_zahl(acht,durch,ersatz);
	}
	if(i == 9){
		anzeige_zahl(neun,durch,ersatz);
	}
	if(i == 98){
		anzeige_zahl(leer,durch,ersatz);
	}
	if(i == 99){
		anzeige_zahl(dp,durch,ersatz);
	}
	return 0;
}
