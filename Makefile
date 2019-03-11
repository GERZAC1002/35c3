CC = gcc
CFLAGS = -Wall -lpthread -ffast-math -Os -s -fno-ident -fno-math-errno -ffunction-sections -fdata-sections -fno-stack-protector -fno-unwind-tables -fno-asynchronous-unwind-tables -Wl,--build-id=none -Wl,-z,norelro -Wl,--gc-sections -Wl,--hash-style=gnu 

pixelflutclient:
	$(CC) $(CFLAGS) -o pixelflut_client pixelflut_client.c
	$(CC) $(CFLAGS) -o pixelflut_client_pixbild pixelflut_client_pixbild.c	
	$(CC) $(CFLAGS) -o pixelflut_client_loesch pixelflut_client_loesch.c
	$(CC) $(CFLAGS) -o pixelflut_client_threads pixelflut_client_threads.c
	$(CC) $(CFLAGS) -o pixelflut_client_request pixelflut_client_request.c
	$(CC) $(CFLAGS) -S pixelflut_client pixelflut_client.c
	$(CC) $(CFLAGS) -S pixelflut_client_pixbild pixelflut_client_pixbild.c
	$(CC) $(CFLAGS) -S pixelflut_client_loesch pixelflut_client_loesch.c
	$(CC) $(CFLAGS) -S pixelflut_client_threads pixelflut_client_threads.c
	$(CC) $(CFLAGS) -S pixelflut_client_request pixelflut_client_request.c


clean:
	rm -f pixelflut_client pixelflut_client_loesch pixelflut_client_pixbild pixelflut_client_threads pixelflut_client_request
