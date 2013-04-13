BINDIR = $(DESTDIR)/opt/qwebirc
INITDIR = $(DESTDIR)/etc/init.d

build:
	cp config.py.example config.py
	./compile.py

install: build
	mkdir -p $(BINDIR)
	mkdir -p $(INITDIR)
	cp -a bin $(BINDIR)
	cp -a css $(BINDIR)
	cp -a dummyauthgate $(BINDIR)
	cp -a esimplejson $(BINDIR)
	cp -a js $(BINDIR)
	cp -a qwebirc $(BINDIR)
	cp -a static $(BINDIR)
	cp -a twisted $(BINDIR)
	cp -a util $(BINDIR)
	cp AUTHORS *.py config.py* $(BINDIR)
	cp LICENSE Makefile qwebirc.pdn qwebirc.png README $(BINDIR)
	cp qwebirc.init $(INITDIR)/qwebirc
	cp .compiled .hg* $(BINDIR)

uninstall:
	rm -rf $(BINDIR)

clean:
	./clean.py
	rm -f config.py
