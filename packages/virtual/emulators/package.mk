# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022 - Fewtarius

PKG_NAME="emulators"
PKG_LICENSE="Apache-2.0"
PKG_SITE="unofficialos.org"
PKG_SECTION="virtual"
PKG_LONGDESC="Emulation metapackage."

PKG_EMUS="hatarisa openbor hypseus-singe moonlight hypseus-singe pico-8 flycastsa   \
          scummvmsa PPSSPPSDL yabasanshiroSA vicesa mupen64plussa-audio-sdl         \
          mupen64plussa-input-sdl mupen64plussa-ui-console mupen64plussa-video-rice \
          mupen64plussa-core mupen64plussa-rsp-hle mupen64plussa-rsp-cxd4 mupen64plussa-video-glide64mk2 \
          mupen64plussa-video-gliden64 lzdoom gzdoom ecwolf amiberry raze"

PKG_RETROARCH="core-info libretro-database retroarch retroarch-assets retroarch-joypads                  \
              retroarch-overlays slang-shaders"

LIBRETRO_CORES="2048 81 a5200 atari800 beetle-gba beetle-lynx beetle-ngp beetle-pce beetle-pce-fast beetle-pcfx      \
                beetle-supafaust beetle-supergrafx beetle-vb beetle-wswan bluemsx cannonball cap32   \
                crocods daphne dinothawr dosbox-svn dosbox-pure easyrpg fbalpha2012                  \
                fbalpha2019 fbneo fceumm fmsx flycast freechaf freeintv             \
                freej2me fuse-libretro gambatte gearboy gearcoleco gearsystem genesis-plus-gx        \
                genesis-plus-gx-wide gme gpsp gw-libretro handy hatari mame2000 mame2003-plus        \
                mame2010 mame2015 mame melonds meowpc98 mgba mrboom mupen64plus mupen64plus-nx       \
                neocd_libretro nestopia np2kai nxengine o2em opera parallel-n64                      \
                pcsx_rearmed picodrive pokemini potator                                              \
                ppsspp prboom prosystem puae px68k quasi88 quicknes race reminiscence sameboy        \
                sameduck smsplus-gx snes9x snes9x2002 snes9x2005_plus snes9x2010 stella      \
                stella-2014 swanstation tgbdual TIC-80 tyrquake xrick uae4arm uzem vba-next vbam     \
                vecx vice yabasanshiro xmil mesen virtualjaguar ecwolf_libretro vitaquake2           \
                bsnes-mercury-performance duckstation fake08"

### Emulators or cores for specific devices
case "${DEVICE}" in
  RG351P|RG351V|RG351MP|RGB20S)
    PKG_DEPENDS_TARGET+=" common-shaders glsl-shaders drastic scummvm"
  ;;
  RG552)
    PKG_DEPENDS_TARGET+=" duckstationsa dolphinsa dolphin slang-shaders beetle-saturn drastic scummvm"
    LIBRETRO_CORES+=" bsnes-hd"
  ;;
  RG503|RG353P)
    PKG_DEPENDS_TARGET+=" duckstationsa common-shaders glsl-shaders drastic dolphinsa scummvm"
  ;;
  handheld)
    PKG_DEPENDS_TARGET+=" dolphin dolphinsa cemu citra citrasa desmume lrps2 mame melondssa minivmac minivmacsa       \
                        pcsx2sa play primehack rpcs3sa xemu yuzusa"
    LIBRETRO_CORES+=" beetle-psx bsnes-hd"
  ;;
  RK3588)
    PKG_DEPENDS_TARGET+=" dolphin dolphinsa aethersx2 mame pcsx_rearmed box86 box64"
    LIBRETRO_CORES+=" beetle-psx bsnes-hd"
  ;;
  RK3566)
    PKG_DEPENDS_TARGET+=" duckstationsa common-shaders glsl-shaders drastic dolphinsa scummvm box86 box64"
  ;;
esac

PKG_DEPENDS_TARGET+=" ${PKG_EMUS} ${PKG_RETROARCH} ${LIBRETRO_CORES}"
