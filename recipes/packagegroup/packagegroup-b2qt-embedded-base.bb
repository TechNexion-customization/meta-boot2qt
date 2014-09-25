#############################################################################
##
## Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
##
## This file is part of the Qt Enterprise Embedded Scripts of the Qt
## framework.
##
## $QT_BEGIN_LICENSE$
## Commercial License Usage Only
## Licensees holding valid commercial Qt license agreements with Digia
## with an appropriate addendum covering the Qt Enterprise Embedded Scripts,
## may use this file in accordance with the terms contained in said license
## agreement.
##
## For further information use the contact form at
## http://qt.digia.com/contact-us.
##
##
## $QT_END_LICENSE$
##
#############################################################################

DESCRIPTION = "Packagegroup for B2Qt embedded Linux image"
LICENSE = "CLOSED"
PR = "r0"

inherit packagegroup

RDEPENDS_${PN} = "\
        kernel-modules \
        adbd \
        psplash \
        openssh-sftp-server \
        openssl \
        openssl-misc \
        libpng \
        jpeg \
        tiff \
        libxslt \
        icu \
        freetype \
        fontconfig \
        liberation-fonts \
        tslib \
        tslib-calibrate \
        alsa-utils-amixer \
        hunspell \
        ca-certificates \
        linux-firmware \
        ${MACHINE_EXTRA_INSTALL} \
        "