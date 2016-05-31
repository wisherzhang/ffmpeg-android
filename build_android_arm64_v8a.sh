#!/bin/bash
#Change NDK to your Android NDK location
NDK=/home/zgwei1986/workspace/webrtc201512/src/chromium/src/third_party/android_tools/ndk
PLATFORM=$NDK/platforms/android-21/arch-arm64/
PREBUILT=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64
MP3_HOME=/home/zgwei1986/workspace/mp3/include

GENERAL="\
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=aarch64 \
--cc=$PREBUILT/bin/aarch64-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/aarch64-linux-android- \
--nm=$PREBUILT/bin/aarch64-linux-android-nm \
--extra-cflags="-I$MP3_HOME" 
--extra-ldflags="-L/home/zgwei1986/workspace/mp3/lib/arm64-v8a" "

MODULES="\
--enable-gpl "



function build_arm64
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=./android/arm64-v8a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags="-DSTDC_HEADERS -DANDROID -fno-builtin-memset" \
  --extra-ldflags="-lmp3lame -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -lc -lm -ldl -llog" \
  --enable-version3 --enable-gpl --enable-nonfree --disable-shared --disable-stripping \
  --disable-ffmpeg --disable-ffplay --disable-ffserver --disable-ffprobe --disable-protocols --enable-protocol=file --enable-protocol=udp \
  --enable-protocol=tcp --enable-protocol=http --enable-network --disable-muxers --enable-muxer=mov  --enable-muxer=mjpeg --disable-avdevice --disable-indevs --disable-bsfs \
  --disable-encoders --enable-encoder=mjpeg --enable-encoder=h263 --enable-encoder=libmp3lame --disable-decoders --enable-decoder=h264 --disable-parsers --disable-devices --disable-parsers \
  --disable-demuxers --enable-demuxer=mov --disable-postproc  --disable-debug  --enable-cross-compile --disable-filters --disable-asm --disable-yasm --enable-avfilter --enable-libmp3lame\
  --enable-neon --enable-armv5te \
  --disable-doc \
  ${MODULES}

  make clean
  make
  make install
}

build_arm64


echo Android ARM64 builds finished
