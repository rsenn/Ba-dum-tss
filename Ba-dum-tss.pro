TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt
CONFIG += link_pkgconfig

PKGCONFIG += freetype2
PKGCONFIG += freeglut
PKGCONFIG += gl glu

TARGET = Ba-dum-tss



unix {
  DEFINES += __PLATFORM_LINUX__=1
  DEFINES += __UNIX_JACK__=1
  PKGCONFIG += jack
}

INCLUDEPATH += \
  src/core \
  src/nehe \
  src/rtaudio \
  src/stk \
  src/x-api \
  src/y-api \


SOURCES += \
    src/core/bk-sim.cpp \
    src/core/dm-audio.cpp \
    src/core/dm-gfx.cpp \
    src/core/dm-globals.cpp \
    src/nehe/FreeType.cpp \
    src/rtaudio/RtAudio.cpp \
    src/stk/Delay.cpp \
    src/stk/DelayL.cpp \
    src/stk/MidiFileIn.cpp \
    src/stk/Stk.cpp \
    src/x-api/x-audio.cpp \
    src/x-api/x-buffer.cpp \
    src/x-api/x-fun.cpp \
    src/x-api/x-gfx.cpp \
    src/x-api/x-loadlum.cpp \
    src/x-api/x-loadrgb.cpp \
    src/x-api/x-thread.cpp \
    src/x-api/x-vector3d.cpp \
    src/y-api/y-charting.cpp \
    src/y-api/y-echo.cpp \
    src/y-api/y-entity.cpp \
    src/y-api/y-fft.cpp \
    src/y-api/y-fluidsynth.cpp \
    src/y-api/y-particle.cpp \
    src/y-api/y-score-reader.cpp \
    src/y-api/y-waveform.cpp \
    src/main.cpp
HEADERS += \
    src/core/bk-sim.h \
    src/core/dm-audio.h \
    src/core/dm-gfx.h \
    src/core/dm-globals.h \
    src/nehe/FreeType.h \
    src/rtaudio/RtAudio.h \
    src/rtaudio/RtError.h \
    src/stk/Delay.h \
    src/stk/DelayL.h \
    src/stk/Filter.h \
    src/stk/MidiFileIn.h \
    src/stk/Stk.h \
    src/x-api/x-audio.h \
    src/x-api/x-buffer.h \
    src/x-api/x-def.h \
    src/x-api/x-fun.h \
    src/x-api/x-gfx-osx.h \
    src/x-api/x-gfx.h \
    src/x-api/x-loadlum.h \
    src/x-api/x-loadrgb.h \
    src/x-api/x-network-osx.h \
    src/x-api/x-thread.h \
    src/x-api/x-vector3d.h \
    src/y-api/y-charting.h \
    src/y-api/y-echo.h \
    src/y-api/y-entity.h \
    src/y-api/y-fft.h \
    src/y-api/y-fluidsynth.h \
    src/y-api/y-particle.h \
    src/y-api/y-score-reader.h \
    src/y-api/y-waveform.h
