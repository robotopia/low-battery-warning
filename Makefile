.PHONY: all clean install uninstall

PREFIX = /usr
SRC = lowbattery.c
OBJ = $(SRC:.c=.o)

all: lowbattery

.c.o:
	gcc -O2 `pkg-config --cflags libnotify`-c $<

lowbattery: lowbattery.o
	gcc `pkg-config --libs libnotify` lowbattery.o -o lowbattery

clean:
	rm -f lowbattery $(OBJ)

install: all
	mkdir -p $(DESTDIR)/$(PREFIX)/local/bin
	mkdir -p $(DESTDIR)/$(PREFIX)/lib/systemd/system
	cp -f lowbattery $(DESTDIR)/$(PREFIX)/local/bin
	chmod 755 $(DESTDIR)/$(PREFIX)/local/bin/lowbattery
	cp -f lowbattery.service $(DESTDIR)/$(PREFIX)/lib/systemd/system/lowbattery.service
#uninstall:
	#rm -f $(DESTDIR)/$(PREFIX)/local/bin/lowbattery
	#rm -f /etc/systemd/system/lowbattery.service
