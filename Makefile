#!/usr/bin/make -f

include ./VERSION
THEME= $(CODENAME_SAFE)
SIZES= 800x600 1024x600 1024x768 1152x864 1280x720 1280x800 1280x1024 \
       1366x768 1440x900 1440x1050 1600x1200 1680x1050 1920x1080 1920x1200

all: clean prepare $(SIZES)

prepare:
	mkdir -p $(THEME)
	cp -a theme $(THEME)

$(SIZES):
	mkdir -p $(THEME)
	ln -sf /usr/share/wallpapers/$(THEME)/contents/images/$@.jpg $(THEME)/$@.jpg;

clean:
	$(RM) -r $(THEME);
