#!/bin/sh
############################################################################
##
## Copyright (C) 2016 The Qt Company Ltd.
## Contact: https://www.qt.io/licensing/
##
## This file is part of the Boot to Qt meta layer.
##
## $QT_BEGIN_LICENSE:GPL$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see https://www.qt.io/terms-conditions. For further
## information use the contact form at https://www.qt.io/contact-us.
##
## GNU General Public License Usage
## Alternatively, this file may be used under the terms of the GNU
## General Public License version 3 or (at your option) any later version
## approved by the KDE Free Qt Foundation. The licenses are as published by
## the Free Software Foundation and appearing in the file LICENSE.GPL3
## included in the packaging of this file. Please review the following
## information to ensure the GNU General Public License requirements will
## be met: https://www.gnu.org/licenses/gpl-3.0.html.
##
## $QT_END_LICENSE$
##
############################################################################

while test -n "$1"; do
  case "$1" in
    "--help" | "-h")
      echo "Usage: . $0 [build directory]"
      return 0
      ;;
    *)
      BUILDDIRECTORY=$1
    ;;
  esac
  shift
done

THIS_SCRIPT="setup-environment.sh"
if [ "$(basename -- $0)" = "${THIS_SCRIPT}" ]; then
    echo "Error: This script needs to be sourced. Please run as '. $0'"
    return 1
fi

if [ -z "$MACHINE" ]; then
  echo "Error: MACHINE environment variable not defined"
  return 1
fi

BUILDDIRECTORY=${BUILDDIRECTORY:-build-${MACHINE}}

if [ ! -f ${PWD}/${BUILDDIRECTORY}/conf/bblayers.conf ]; then
  case ${MACHINE} in
    imx8qmmek|imx8mqevk)
      LAYERSCONF="bblayers.conf.fsl-imx8.sample"
    ;;
    apalis-imx8|colibri-imx8qxp)
      LAYERSCONF="bblayers.conf.toradex-imx8.sample"
    ;;
    apalis-imx6|colibri-imx6|colibri-imx6ull|colibri-vf|colibri-imx7|colibri-imx7-emmc)
      LAYERSCONF="bblayers.conf.toradex.sample"
    ;;
    nitrogen6x|nitrogen7)
      LAYERSCONF="bblayers.conf.boundary.sample"
    ;;
    pico-imx6|pico-imx6ul|pico-imx6ull|pico-imx7|pico-imx8mq|pico-imx8mm|flex-imx8mm|edm-imx8mq|edm-imx6|edm-imx7)
      LAYERSCONF="bblayers.conf.technexion.sample"
    ;;
    imx6qdlsabresd|imx7dsabresd|imx7s-warp)
      LAYERSCONF="bblayers.conf.fsl.sample"
    ;;
    smarc-samx6i)
      LAYERSCONF="bblayers.conf.smx6.sample"
    ;;
    raspberrypi0|raspberrypi|raspberrypi2|raspberrypi3)
      LAYERSCONF="bblayers.conf.rpi.sample"
    ;;
    intel-corei7-64)
      LAYERSCONF="bblayers.conf.intel.sample"
    ;;
    tegra-x1|tegra-t18x)
      LAYERSCONF="bblayers.conf.nvidia-tegra.sample"
    ;;
    salvator-x|h3ulcb|m3ulcb|ebisu)
      LAYERSCONF="bblayers.conf.rcar-gen3.sample"
    ;;
    draak)
      LAYERSCONF="bblayers.conf.draak.sample"
    ;;
    emulator)
      LAYERSCONF="bblayers.conf.emulator.sample"
    ;;
    jetson-tx1|jetson-tx2|jetson-tk1)
      LAYERSCONF="bblayers.conf.jetson.sample"
    ;;
    *)
      LAYERSCONF="bblayers.conf.sample"
      echo "Unknown MACHINE, bblayers.conf might need manual editing"
    ;;
  esac

  mkdir -p ${PWD}/${BUILDDIRECTORY}/conf
  cp ${PWD}/sources/meta-boot2qt/meta-boot2qt-distro/conf/${LAYERSCONF} ${PWD}/${BUILDDIRECTORY}/conf/bblayers.conf

  if [ -e ${PWD}/sources/meta-boot2qt/.QT-FOR-DEVICE-CREATION-LICENSE-AGREEMENT ]; then
    QT_SDK_PATH=$(readlink -f ${PWD}/sources/meta-boot2qt/../../../../)
  fi
fi

export TEMPLATECONF="${PWD}/sources/meta-boot2qt/meta-boot2qt-distro/conf"
. sources/poky/oe-init-build-env ${BUILDDIRECTORY}

# use sources from Qt SDK if that is available
sed -i -e "/QT_SDK_PATH/s:\"\":\"${QT_SDK_PATH}\":" conf/local.conf

unset BUILDDIRECTORY
unset QT_SDK_PATH
unset TEMPLATECONF
unset LAYERSCONF
