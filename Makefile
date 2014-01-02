version=0.14
avconv_exists := $(shell which avconv)
ffmpeg_exists := $(shell which ffmpeg)

all:
ifdef avconv_exists
	@echo "Program 'avconv' found, using that..."
else
	@echo "Couldn't find 'avconv'."
ifdef ffmpeg_exists
	@echo "Program 'ffmpeg' found, using that..."
	sed -i 's/avconv/ffmpeg/g' castawesome.py
else
	@echo "Couldn't find necessary tools. Install 'avconv' or 'ffmpeg'."
endif
endif
	./castawesome.py test

install:
ifdef avconv_exists
	@echo "Program 'avconv' found, using that..."
else
	@echo "Couldn't find 'avconv'."
ifdef ffmpeg_exists
	@echo "Program 'ffmpeg' found, using that..."
	sed -i 's/avconv/ffmpeg/g' castawesome.py
else
	@echo "Couldn't find necessary tools. Install 'avconv' or 'ffmpeg'."
endif
endif
	mkdir -p /usr/local/share/castawesome/ui
	mkdir -p /usr/local/share/castawesome/doc
	cp *.ui /usr/local/share/castawesome/ui
	cp *.png /usr/local/share/castawesome/ui
	cp README AUTHORS NEWS COPYING /usr/local/share/castawesome/doc
	cp castawesome.py /usr/local/bin/castawesome
	cp uninstall_castawesome.sh /usr/local/bin/uninstall_castawesome
	cp Castawesome.desktop /usr/local/share/applications
	chmod +x /usr/local/bin/castawesome /usr/local/bin/uninstall_castawesome
	chmod +r /usr/local/share/castawesome/ui/*.png

uninstall:
	rm -rf /usr/local/share/castawesome
	rm -f /usr/local/bin/castawesome /usr/local/bin/uninstall_castawesome
	rm -f /usr/local/share/applications/Castawesome.desktop

package:
	rm -f castawesome*.tar.gz
	tar czf castawesome-$(version).tar.gz *

clean:
	rm -f castawesome*.tar.gz
