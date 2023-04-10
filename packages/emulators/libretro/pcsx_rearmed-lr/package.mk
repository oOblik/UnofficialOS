# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Trond Haugland (trondah@gmail.com)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="pcsx_rearmed-lr"
PKG_VERSION="4373e29de72c917dbcd04ec2a5fb685e69d9def3"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${TARGET_ARCH}/${DEVICE}"

make_target() {
  cd ${PKG_BUILD}
  if [[ "${DEVICE}" =~ RG351 ]] || [[ "${DEVICE}" =~ RGB20S ]]
  then
    make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=RG351x
  elif [[ "${DEVICE}" =~ RG503 ]] || [[ "${DEVICE}" =~ RG353P ]] || [[ "${DEVICE}" =~ RK3566 ]]
  then
    make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=RK3566
  else
    make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=${DEVICE}
  fi
}

makeinstall_target() {
  ## Install the 64bit core.
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/
  if [ -f "${ROOT}/build.${DISTRO}-${DEVICE}.arm/pcsx_rearmed-lr-*/.install_pkg/usr/lib/libretro/pcsx_rearmed_libretro.so" ] && \
     [ "${TARGET_ARCH}" = "aarch64" ]
  then
    cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/pcsx_rearmed-lr-*/.install_pkg/usr/lib/libretro/pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/pcsx_rearmed32_libretro.so
  fi
}

