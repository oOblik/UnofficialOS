# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rkbin"
PKG_VERSION="7d631e0"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/RetroGFX/rkbin"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"

case "${DEVICE}" in
  RG351|RGB20S)
    PKG_VERSION="73945d35fd3a7fe1c7037209e36dd5a0b32c5560"
  ;;
  RK3588|RK3566)
    PKG_SITE="https://github.com/radxa/rkbin"
    PKG_VERSION="9840e87723eef7c41235b89af8c049c1bcd3d133"
  ;;
esac

PKG_URL="${PKG_SITE}.git"
PKG_PATCH_DIRS+="${DEVICE}"
