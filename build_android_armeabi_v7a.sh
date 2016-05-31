#!/bin/bash
#Change NDK to your Android NDK location
NDK=/home/zgwei1986/workspace/webrtc201512/src/chromium/src/third_party/android_tools/ndk
PLATFORM=$NDK/platforms/android-19/arch-arm
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64
MP3_HOME=/home/zgwei1986/workspace/mp3/include
GENERAL="\
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=arm \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm \
--extra-cflags="-I$MP3_HOME" 
--extra-ldflags="-L/home/zgwei1986/workspace/mp3/lib/armeabi" "


MODULES="\
--enable-gpl "

function build_ARMv7
{
  ./configure \
  --target-os=linux \
  --prefix=./android/armeabi-v7a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --enable-version3 --enable-gpl --enable-nonfree --disable-shared --disable-stripping \
  --disable-ffmpeg --disable-ffplay --disable-ffserver --disable-ffprobe --disable-protocols --enable-protocol=file --enable-protocol=udp \
  --enable-protocol=tcp --enable-protocol=http --enable-network --disable-muxers --enable-muxer=mov  --enable-muxer=mjpeg --disable-avdevice --disable-indevs --disable-bsfs \
  --disable-encoders --enable-encoder=mjpeg --enable-encoder=h263 --enable-encoder=libmp3lame --disable-decoders --enable-decoder=h264 --disable-parsers --disable-devices --disable-parsers \
  --disable-demuxers --enable-demuxer=mov --disable-postproc  --disable-debug  --enable-cross-compile --disable-filters --disable-asm --disable-yasm --enable-avfilter --enable-libmp3lame\
  --enable-neon --enable-armv5te \
  --extra-cflags="-DANDROID -fPIC -ffunction-sections -funwind-tables -fstack-protector -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300" \
  --extra-ldflags="-lmp3lame -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  ${MODULES} \
  --enable-neon

  make clean
  make
  make install
}

build_ARMv7
echo Android ARMv7-a builds finished
