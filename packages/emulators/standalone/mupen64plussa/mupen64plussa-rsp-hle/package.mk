# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plussa-ui-console"
PKG_VERSION="3ad5cbb56fcf4921ffae8c7b8ee52ea0ae82c044"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-ui-console"
PKG_URL="https://github.com/mupen64plus/mupen64plus-ui-console/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plussa-core"
PKG_SHORTDESC="mupen64plus-ui-console"
PKG_LONGDESC="Mupen64Plus Standalone Console"
PKG_TOOLCHAIN="manual"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+="USE_GLES=1"
fi

make_target() {
  case ${ARCH} in
    arm|aarch64)
      export HOST_CPU=aarch64
      export USE_GLES=1
      BINUTILS="$(get_build_dir binutils)/.aarch64-libreelec-linux-gnueabi"
    ;;
  esac
  export APIDIR=$(get_build_dir mupen64plussa-core)/.install_pkg/usr/local/include/mupen64plus
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"
  export V=1
  export VC=0
  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/projects/unix/mupen64plus-rsp-hle.so ${UPLUGINDIR}
  #${STRIP} ${UPLUGINDIR}/mupen64plus-rsp-hle.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-rsp-hle.so
}