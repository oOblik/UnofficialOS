# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022 - Fewtarius

PKG_NAME="emulators"
PKG_LICENSE="Apache-2.0"
PKG_SITE="unofficialos.org"
PKG_SECTION="virtual"
PKG_LONGDESC="Emulation metapackage."

PKG_EMUS="hatarisa openbor moonlight hypseus hypseus-singe pico-8 flycast-sa   \
          scummvmsa PPSSPPSDL yabasanshiro-sa vicesa mupen64plus-sa-audio-sdl         \
          mupen64plus-sa-input-sdl mupen64plus-sa-ui-console mupen64plus-sa-video-rice \
          mupen64plus-sa-core mupen64plus-sa-rsp-hle mupen64plus-sa-rsp-cxd4 mupen64plus-sa-video-glide64mk2 \
          mupen64plus-sa-video-gliden64 lzdoom gzdoom ecwolf amiberry raze"

PKG_RETROARCH="core-info libretro-database retroarch retroarch-assets retroarch-joypads retroarch-overlays     \
              slang-shaders"

LIBRETRO_CORES="2048-lr 81-lr a5200-lr atari800-lr beetle-gba-lr beetle-lynx-lr beetle-ngp-lr beetle-pce-lr beetle-pce-fast-lr beetle-pcfx-lr      \
                beetle-supafaust-lr beetle-supergrafx-lr beetle-vb-lr beetle-wswan-lr bluemsx-lr cannonball-lr cap32-lr   \
                crocods-lr daphne-lr dinothawr-lr dosbox-svn-lr dosbox-pure-lr easyrpg-lr fbalpha2012-lr                  \
                fbalpha2019-lr fbneo-lr fceumm-lr fmsx-lr flycast-lr freechaf-lr freeintv-lr             \
                freej2me-lr fuse-lr gambatte-lr gearboy-lr gearcoleco-lr gearsystem-lr genesis-plus-gx-lr        \
                genesis-plus-gx-wide-lr gme-lr gpsp gw-lr handy-lr hatari-lr mame2000-lr mame2003-plus-lr        \
                mame2010-lr mame2015-lr mame-lr melonds-lr meowpc98-lr mgba-lr mrboom-lr mupen64plus-lr mupen64plus-nx-lr       \
                neocd_lr nestopia-lr np2kai-lr nxengine-lr o2em-lr opera-lr parallel-n64-lr                      \
                pcsx_rearmed-lr picodrive-lr pokemini-lr potator-lr                                              \
                ppsspp-lr prboom-lr prosystem-lr puae-lr px68k-lr quasi88-lr quicknes-lr race-lr reminiscence-lr sameboy-lr        \
                sameduck-lr smsplus-gx-lr snes9x-lr snes9x2002-lr snes9x2005_plus-lr snes9x2010-lr stella-lr      \
                stella-2014-lr swanstation-lr tgbdual-lr TIC-80-lr tyrquake-lr xrick-lr uae4arm uzem-lr vba-next-lr vbam-lr     \
                vecx-lr vice-lr yabasanshiro-lr xmil-lr mesen-lr virtualjaguar-lr ecwolf_libretro vitaquake2           \
                bsnes-mercury-performance-lr duckstation-lr fake08-lr"

### Emulators or cores for specific devices
case "${DEVICE}" in
  RG351P|RG351V|RG351MP|RGB20S)
    PKG_DEPENDS_TARGET+=" common-shaders glsl-shaders drastic scummvm"
  ;;
  RG552)
    PKG_DEPENDS_TARGET+=" duckstation-sa dolphin-sa dolphin slang-shaders beetle-saturn drastic scummvm"
    LIBRETRO_CORES+=" bsnes-hd-lr"
  ;;
  RG503|RG353P)
    PKG_DEPENDS_TARGET+=" common-shaders glsl-shaders drastic dolphin-sa scummvm"
  ;;
  handheld)
    PKG_EMUS+=" duckstation-sa dolphin-sa cemu-sa citra-sa flycast-sa melonds-sa minivmacsa mupen64plus-sa pcsx2-sa          \
               primehack rpcs3-sa ryujinx-sa xemu-sa yuzu-sa"
    LIBRETRO_CORES+=" beetle-psx-lr bsnes-hd-lr citra-lr desmume-lr dolphin-lr lrps2-lr mame-lr minivmac-lr    \
                     play-lr"
  ;;
  RK3588)
    PKG_EMUS+=" aethersx2-sa duckstation-sa dolphin mame pcsx_rearmed-lr box86 box64"
    LIBRETRO_CORES+=" beetle-psx-lr bsnes-hd-lr dolphin-lr"
  ;;
  RK3566)
    PKG_DEPENDS_TARGET+=" common-shaders glsl-shaders drastic dolphin-sa scummvm box86 box64"
  ;;
  OGU)
    PKG_EMUS+=" aethersx2-sa dolphin-sa duckstation-sa mupen64plus-sa yabasanshiro-sa"
    LIBRETRO_CORES+=" beetle-psx-lr bsnes-hd-lr dolphin-lr pcsx_rearmed-lr box86 box64 yabasanshiro-sa"
esac

PKG_DEPENDS_TARGET+=" ${PKG_EMUS} ${PKG_RETROARCH} ${LIBRETRO_CORES}"
