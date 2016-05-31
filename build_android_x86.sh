#!/bin/bash
#Change NDK to your Android NDK location
NDK=/home/zgwei1986/workspace/webrtc201512/src/chromium/src/third_party/android_tools/ndk
PLATFORM=$NDK/platforms/android-21/arch-x86/
PREBUILT=$NDK/toolchains/x86-4.9/prebuilt/linux-x86_64
MP3_HOME=/home/zgwei1986/workspace/mp3/include


GENERAL="\
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$PREBUILT/bin/i686-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/i686-linux-android- \
--nm=$PREBUILT/bin/i686-linux-android-nm \
--extra-cflags="-I$MP3_HOME" 
--extra-ldflags="-L/home/zgwei1986/workspace/mp3/lib/x86" "

MODULES="\
--enable-gpl "


function build_x86
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=./android/x86 \
  --arch=x86 \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --enable-version3 --enable-gpl --enable-nonfree --disable-shared --disable-stripping \
  --disable-ffmpeg --disable-ffplay --disable-ffserver --disable-ffprobe --disable-protocols --enable-protocol=file --enable-protocol=udp \
  --enable-protocol=tcp --enable-protocol=http --enable-network --disable-muxers --enable-muxer=mov  --enable-muxer=mjpeg --disable-avdevice --disable-indevs --disable-bsfs \
  --disable-encoders --enable-encoder=mjpeg --enable-encoder=h263 --enable-encoder=libmp3lame --disable-decoders --enable-decoder=h264 --disable-parsers --disable-devices --disable-parsers \
  --disable-demuxers --enable-demuxer=mov --disable-postproc  --disable-debug  --enable-cross-compile --disable-filters --disable-asm --disable-yasm --enable-avfilter --enable-libmp3lame\
  --enable-neon --enable-armv5te \
  --extra-cflags=" -O3 -DHAVE_MEMCPY -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8" \
  --extra-cflags="-march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32" \
  --extra-ldflags="-lmp3lame -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib  -lc -lm -ldl -llog" \
  --disable-doc \
  ${MODULES}

  make clean
  make
  make install
}

build_x86


echo Android X86 builds finished
