# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="duckstationsa"
PKG_LICENSE="GPLv3"
PKG_DEPENDS_TARGET="toolchain SDL2 nasm:host pulseaudio openssl libidn2 nghttp2 zlib curl libevdev ecm"
PKG_SITE="https://github.com/stenzek/duckstation"
PKG_URL="${PKG_SITE}.git"
PKG_SHORTDESC="Fast PlayStation 1 emulator for x86-64/AArch32/AArch64 "
PKG_TOOLCHAIN="cmake"

case ${DEVICE} in
  RG552|handheld|RK3588)
    PKG_VERSION="51e4c4bfb09f336b5b6ad5b75b3fffe63799b68c"
    PKG_PATCH_DIRS+=" wayland"
  ;;
  *)
    PKG_VERSION="55e0e7ffbea9143f7809a926cf11c6986971881a"
    PKG_PATCH_DIRS+=" legacy"
  ;;
esac

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_X11=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" 	-DUSE_X11=OFF \
				-DUSE_DRMKMS=ON \
				-DENABLE_EGL=ON \
				-DUSE_MALI=OFF \
                                -DENABLE_VULKAN=OFF"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER} xorg-server xrandr libXi"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_X11=OFF -DUSE_WAYLAND=ON"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=ON"
fi

pre_configure_target() {
	PKG_CMAKE_OPTS_TARGET+="	-DANDROID=OFF \
					-DENABLE_DISCORD_PRESENCE=OFF \
					-DBUILD_QT_FRONTEND=OFF \
					-DBUILD_NOGUI_FRONTEND=ON \
					-DCMAKE_BUILD_TYPE=Release \
					-DBUILD_SHARED_LIBS=OFF \
					-DUSE_SDL2=ON \
					-DENABLE_CHEEVOS=ON \
					-DUSE_FBDEV=OFF \
					-DUSE_EVDEV=ON"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/bin/duckstation-nogui ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/usr/config/duckstation
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/bin/* ${INSTALL}/usr/config/duckstation
  cp -rf ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/duckstation

  rm -rf ${INSTALL}/usr/config/duckstation/duckstation-nogui
  rm -rf ${INSTALL}/usr/config/duckstation/common-tests

  chmod +x ${INSTALL}/usr/bin/start_duckstation.sh
}
