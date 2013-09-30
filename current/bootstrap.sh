#!/bin/sh
set -e

if [ -f ./debian/rules ]; then
    echo "You would run debuild clean first and delete the old debian/rules... "
    exit 1
fi

if [ -f VERSION ]; then
    . ./VERSION
else
    echo "No VERSION-File, exit!"
    exit 1
fi

# clean up obsolete stuff
rm -f ./debian/*.install \
    ./debian/*.links \
    ./debian/*.postinst \
    ./debian/*.postrm

#write toplevel Makefile

ALL_CODENAME_SAFE="${ALL_CODENAME_SAFE} ${NAME}"

sed -e "s/\@ALL_CODENAME_SAFE\@/${ALL_CODENAME_SAFE}/g" \
    ./debian/templates/Makefile.in \
    > ./Makefile

[ -d ./debian ] || exit 1

TEMPLATE_CHANGELOG="./debian/templates/changelog.in"
if [ ! -e ./debian/changelog ]; then 
    sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
        ${TEMPLATE_CHANGELOG} \
        > ./debian/changelog
fi

TEMPLATE_SRC="./debian/templates/control.source.in"
sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ${TEMPLATE_SRC} \
    > ./debian/control

# write debian/control from templates
TEMPLATES_BIN="./debian/templates/control.binary.in"

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    -e "s/\@CODENAME\@/${DESCRIPTION}/g" \
    -e "s/\@VERSION\@/${VERSION}/g" \
    ${TEMPLATES_BIN} \
    >> ./debian/control

# write debian/*.install from templates
for k in kde kdm ksplash lightdm rqt wallpaper xfce xsplash; do
    if [ -r  ./debian/templates/siduction-art-${k}-CODENAME_SAFE.install.in ]; then
        sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
            ./debian/templates/siduction-art-${k}-CODENAME_SAFE.install.in \
            > ./debian/siduction-art-${k}-${NAME}.install
    else
        continue
    fi
done

# write debian/*.postinst from templates
for k in kde kdm ksplash lightdm rqt wallpaper xfce xsplash; do
    if [ -r  ./debian/templates/siduction-art-${k}-CODENAME_SAFE.postinst.in ]; then
        sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
            ./debian/templates/siduction-art-${k}-CODENAME_SAFE.postinst.in \
            > ./debian/siduction-art-${k}-${NAME}.postinst
    else
        continue
    fi
done

# write debian/*.postrm from templates
for k in kde kdm ksplash lightdm rqt wallpaper xfce xsplash; do
    if [ -r  ./debian/templates/siduction-art-${k}-CODENAME_SAFE.postrm.in ]; then
        sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
            ./debian/templates/siduction-art-${k}-CODENAME_SAFE.postrm.in \
            > ./debian/siduction-art-${k}-${NAME}.postrm
    else
        continue
    fi
done

# create links
for k in kde kdm ksplash lightdm rqt wallpaper xfce xsplash; do
    if [ -r  ./debian/templates/siduction-art-${k}-CODENAME_SAFE.links.in ]; then
        sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
            ./debian/templates/siduction-art-${k}-CODENAME_SAFE.links.in \
            > ./debian/siduction-art-${k}-${NAME}.links
    else
        continue
    fi
done

## grub theme
sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/grub-theme-siduction-CODENAME_SAFE.install.in \
    > ./debian/grub-theme-siduction-${NAME}.install

## create Artwork files

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/dm-kdm/CODENAME_SAFE.xml.in \
    > ./artwork/dm-kdm/${NAME}.xml

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/dm-kdm/KdmGreeterTheme.desktop.in \
    > ./artwork/dm-kdm/KdmGreeterTheme.desktop

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/rqt/razor.conf.in \
    > ./artwork/rqt/theme/razor/razor.conf

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/splash-kde/description.txt.in \
    > ./artwork/splash-kde/description.txt

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/splash-kde/Theme.rc.in \
    > ./artwork/splash-kde/Theme.rc

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/splash-xfce/themerc.in \
    > ./artwork/splash-xfce/themerc

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/theme-kde/CODENAME_SAFE.colors.in \
    > ./artwork/theme-kde/${NAME}.colors

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/theme-kde/CODENAME_SAFE-dark.colors.in \
    > ./artwork/theme-kde/${NAME}-dark.colors

sed -e "s/\@CODENAME_SAFE\@/${NAME}/g" \
    ./debian/templates/artwork/wallpaper/metadata.desktop.in \
    > ./artwork/wallpaper/metadata.desktop
