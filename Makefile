#!/usr/bin/make -f

include ./VERSION
THEME= $(CODENAME_SAFE)
SIZES= 640x480 800x600 1024x600 1024x768 1152x864 1280x720 1280x800 1280x1024 \
       1366x768 1440x900 1440x1050 1600x1200 1680x1050 1920x1080 1920x1200 \
       2560x1080 2560x1440 2560x1600 2560x2048 3440x1440 3840x2160

all: clean prepare $(SIZES)

prepare:
	if [ ! -d $(THEME) ]; then \
	mkdir -p $(THEME); \
	fi
	cp -a theme $(THEME)

$(SIZES):
	if [ ! -d $(THEME) ]; then \
	mkdir -p $(THEME); \
	fi
	ln -sf /usr/share/wallpapers/$(THEME)/contents/images/$@.svg $(THEME)/$@.svg;

clean:
	if [ -d $(THEME) ]; then \
	rmdir $(THEME); \
	fi

