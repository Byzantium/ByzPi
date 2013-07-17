BINDIR = $(DESTDIR)/usr/share/etherpad-lite
INITDIR = $(DESTDIR)/etc/init.d

build:
	@echo "I should be building stuff here but I'm not."

install:
	mkdir -p $(BINDIR)
	mkdir -p $(INITDIR)
	cp -a etherpad-lite/bin $(BINDIR)
	cp -a etherpad-lite/doc $(BINDIR)
	cp -a etherpad-lite/src $(BINDIR)
	cp -a etherpad-lite/tests $(BINDIR)
	cp -a etherpad-lite/tools $(BINDIR)
	cp -a etherpad-lite/var $(BINDIR)
	cp etherpad-lite/*.md etherpad-lite/LICENSE $(BINDIR)
	cp etherpad-lite/Makefile etherpad-lite/settings.json.template $(BINDIR)
	cp etherpad-lite/start.bat $(BINDIR)
	cp etherpad-lite.init $(INITDIR)/etherpad-lite

uninstall:
	rm -rf $(BINDIR) $(INITDIR)

clean:
	@echo "I should be cleaning out old files here but I'm not."
