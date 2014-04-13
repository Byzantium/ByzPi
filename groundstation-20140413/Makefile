BINDIR = $(DESTDIR)/opt/groundstation
INITDIR = $(DESTDIR)/etc/init.d

build:
	@echo "Building Groundstation."
	cd debian/groundstation
	@echo "Setting up Python sandbox."
	virtualenv env
	. env/bin/activate
	pip install -r requirements.txt

install:
	@echo "Installing Groundstation."
	mkdir -p $(BINDIR)
	mkdir -p $(INITDIR)
	cp -a groundstation/ $(BINDIR)
	cp groundstation/airshipd.sh $(BINDIR)
	cp groundstation/stationd.sh $(BINDIR)
	cp groundstation.init $(INITDIR)/groundstation
	# Here we use curl to make the initial chat databases...

uninstall:
	@echo "Uninstalling Groundstation."
	rm -rf $(BINDIR)
	rm -f $(INITDIR)/groundstation

clean:
	@echo "Cleaning Groundstation."
	cd debian/groundstation
	rm -rf env
	cd ../..
