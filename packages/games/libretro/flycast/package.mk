# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present AmberELEC (https://github.com/AmberELEC)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="flycast"
PKG_VERSION="8fdcea2e2083d153c3fa729f0df991f434bf246d"
PKG_SITE="https://github.com/flyinghead/flycast"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libzip"
PKG_LONGDESC="Flycast is a multi-platform Sega Dreamcast, Naomi and Atomiswave emulator"
PKG_TOOLCHAIN="cmake"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
  PKG_CMAKE_OPTS_TARGET+="  USE_OPENGL=ON"
else
  PKG_CMAKE_OPTS_TARGET+="  USE_OPENGL=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = yes ] | [ ! "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=OFF"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=OFF"
fi

pre_configure_target() {
  sed -i 's/"reicast"/"flycast"/g' ${PKG_BUILD}/shell/libretro/libretro_core_option_defines.h 
  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET} \
			 -Wno-dev -DLIBRETRO=ON \
                         -DWITH_SYSTEM_ZLIB=ON \
                         -DUSE_OPENMP=ON"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp flycast_libretro.so ${INSTALL}/usr/lib/libretro/flycast_libretro.so
}
