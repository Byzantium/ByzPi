BINDIR = $(DESTDIR)/opt/qwebirc

build:
	cp config.py.example config.py
	./compile.py

install: build
	mkdir -p $(BINDIR)
	cp -a bin $(BINDIR)
	cp -a css $(BINDIR)
	cp -a dummyauthgate $(BINDIR)
	cp -a esimplejson $(BINDIR)
	cp -a js $(BINDIR)
	cp -a qwebirc $(BINDIR)
	cp -a static $(BINDIR)
	cp -a twisted $(BINDIR)
	cp -a util $(BINDIR)
	cp AUTHORS clean.py compile.py config.py* $(BINDIR)
	cp LICENSE Makefile qwebirc.pdn qwebirc.png README run.py $(BINDIR)

uninstall:
	rm -rf $(BINDIR)

clean:
	./clean.py
	rm -f config.py
