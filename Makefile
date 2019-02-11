CC = gcc
CFLAGS = -Wall -lpthread

pixelflutclient:
	$(CC) $(CFLAGS) -o pixelflut_client pixelflut_client.c
	$(CC) $(CFLAGS) -o pixelflut_client_pixbild pixelflut_client_pixbild.c	
	$(CC) $(CFLAGS) -o pixelflut_client_loesch pixelflut_client_loesch.c
	$(CC) $(CFLAGS) -o pixelflut_client_threads pixelflut_client_threads.c
	$(CC) $(CFLAGS) -o pixelflut_client_request pixelflut_client_request.c

clean:
	rm -f pixelflut_client pixelflut_client_loesch pixelflut_client_pixbild pixelflut_client_threads pixelflut_client_request
