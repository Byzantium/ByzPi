BINDIR = $(DESTDIR)/usr/share/etherpad-lite
INITDIR = $(DESTDIR)/etc/init.d

build:
	cd etherpad-lite
	make
	cd ..

install: build
	mkdir -p $(BINDIR)
	mkdir -p $(INITDIR)
	cp -a etherpad-lite/bin $(BINDIR)
	cp -a etherpad-lite/doc $(BINDIR)
	cp -a etherpad-lite/src $(BINDIR)
	cp -a etherpad-lite/tests $(BINDIR)
	cp -a etherpad-lite/tools $(BINDIR)
	cp -a etherpad-lite/var $(BINDIR)
	cp *.md LICENSE Makefile settings.json.template start.bat $(BINDIR)
	cp etherpad-lite.init $(INITDIR)/etherpad-lite

uninstall:
	rm -rf $(BINDIR) $(INITDIR)

clean:
	cd etherpad-lite
	make clean
	cd ..
