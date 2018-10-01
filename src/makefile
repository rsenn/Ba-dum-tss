SYSTEM := $(shell uname -o)

ifeq ($(SYSTEM),Msys)
  SYSTEM := MinGW
endif
$(info SYSTEM=$(SYSTEM))
CXX = g++

GLUT := freeglut

ifeq ($(DEBUG),1)
CXXFLAGS = -g -ggdb -O0
else
CXXFLAGS = -g -O2
endif

#INCLUDES = -Icore/ -Irtaudio/ -Istk/ -Ix-api/ -Iy-api/ -I/opt/local/include
INCLUDES := -I core -I rtaudio -I stk -I x-api -I y-api -I nehe
EXEEXT := 
O := o

ifeq ($(SYSTEM),MinGW)
 CXX = x86_64-w64-mingw32-g++
 CXXFLAGS += $(shell PKG_CONFIG_LIBDIR=/usr/x86_64-w64-mingw32/lib/pkgconfig  pkg-config --cflags  fluidsynth ) -DNO_CHECK_EXISTS $(INCLUDES) -c
 CXXFLAGS += -D__WINDOWS_PTHREAD__
 LIBS = $(shell PKG_CONFIG_LIBDIR=/usr/x86_64-w64-mingw32/lib/pkgconfig  pkg-config --libs fluidsynth)
 CXXFLAGS += -DFREEGLUT_STATIC
 ifeq ($(GLUT),freeglut)
  LIBS += -lfreeglut_static 
 else
  LIBS += -lopenglut
 endif
 LIBS += -lglu32 -lopengl32 -ldsound -lwinmm -lgdi32 -lole32 -lm
 SNDDRV ?= dsound
 EXEEXT = .exe
 O = obj
else
 ifeq ($(SYSTEM),Linux)
  CXXFLAGS +=  -std=c++11 $(INCLUDES) -c -D__PLATFORM_LINUX__
  SNDDRV ?= alsa
   LIBS  := $(shell pkg-config --libs freetype2 fluidsynth $(SNDDRV) ) 
  ifeq ($(STATIC),1)
   LIBS  := $(shell pkg-config --libs freeglut freetype2 fluidsynth $(SNDDRV) ) 
  ##LIBS  := $(shell pkg-config -static --libs freetype2 fluidsynth $(SNDDRV) ) 
   LIBS := $(patsubst -l%,/usr/lib/lib%.a,$(LIBS))
   LIBS +=  $(patsubst %,/usr/lib/lib%.a,glib-2.0 sndfile vorbisenc vorbis FLAC ogg png15 bz2 z GLU)
   LIBS += $(shell pkg-config --libs gl )
   LDFLAGS += -static-libgcc -static-libstdc++
  else  
   LIBS += $(shell pkg-config --libs gl glu ) 
  endif
  #LIBS  += -lstdc++
  
  LIBS += -lpthread -lm
  LIBS += -ldl
  #LIBS  += -lboost_filesystem
 else
   CXXFLAGS += -D__MACOSX_CORE__ $(INCLUDES) -c
   LIBS  = -framework CoreAudio -framework CoreMIDI -framework CoreFoundation \
 		   -framework IOKit -framework Carbon -framework OpenGL \
 		   -framework GLUT -lstdc++ -lm
   SNDDRV ?= coreaudio
 endif

 ifneq ($(STATIC),1)
  ifeq ($(GLUT),freeglut)
   LIBS  += $(shell pkg-config --libs $(GLUT))
  else
   LIBS  += -l${GLUT}
  endif
 else
   LIBS += -lX11 -lXrandr -lXxf86vm -lXi
 endif
endif
ifneq ($(GLUT),freeglut)
CXXFLAGS += -DUSE_OPENGLUT
endif

CXXFLAGS += -DNO_CHECK_EXISTS

TARGET := ba_dum_tss.$(SNDDRV)$(EXEEXT)

OBJS := main.$(O) core/dm-globals.$(O) core/dm-audio.$(O) core/dm-gfx.$(O) core/bk-sim.$(O) x-api/x-audio.$(O) x-api/x-buffer.$(O) x-api/x-fun.$(O) \
	x-api/x-gfx.$(O) x-api/x-loadlum.$(O) x-api/x-loadrgb.$(O) x-api/x-thread.$(O) \
	x-api/x-vector3d.$(O) y-api/y-charting.$(O) y-api/y-echo.$(O) y-api/y-entity.$(O) \
	y-api/y-fft.$(O) y-api/y-fluidsynth.$(O) y-api/y-particle.$(O) y-api/y-score-reader.$(O) y-api/y-waveform.$(O) \
	stk/Delay.$(O) stk/DelayL.$(O) stk/MidiFileIn.$(O) \
	stk/Stk.$(O) \
	nehe/FreeType.$(O)


all: $(TARGET)

$(info OBJS: $(OBJS))
$(info EXEEXT: $(EXEEXT))
$(info TARGET: $(TARGET))

ba_dum_tss.dsound$(EXEEXT): $(OBJS) rtaudio/RtAudio-dsound.$(O)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LIBS)

ba_dum_tss.jack$(EXEEXT): $(OBJS) rtaudio/RtAudio-jack.$(O)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LIBS)

ba_dum_tss.alsa$(EXEEXT): $(OBJS) rtaudio/RtAudio-alsa.$(O)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LIBS)

main.$(O): main.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

core/dm-globals.$(O): core/dm-globals.cpp core/dm-globals.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

core/dm-audio.$(O): core/dm-audio.cpp core/dm-audio.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

core/dm-gfx.$(O): core/dm-gfx.cpp core/dm-gfx.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

core/bk-sim.$(O): core/bk-sim.cpp core/bk-sim.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

x-api/x-audio.$(O): x-api/x-audio.cpp x-api/x-audio.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

x-api/x-buffer.$(O): x-api/x-buffer.cpp x-api/x-buffer.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

x-api/x-fun.$(O): x-api/x-fun.cpp x-api/x-fun.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

x-api/x-gfx.$(O): x-api/x-gfx.cpp x-api/x-gfx.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

x-api/x-loadlum.$(O): x-api/x-loadlum.cpp x-api/x-loadlum.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

x-api/x-loadrgb.$(O): x-api/x-loadrgb.cpp x-api/x-loadrgb.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

x-api/x-thread.$(O): x-api/x-thread.cpp x-api/x-thread.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

x-api/x-vector3d.$(O): x-api/x-vector3d.cpp x-api/x-vector3d.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

y-api/y-charting.$(O): y-api/y-charting.cpp y-api/y-charting.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

y-api/y-echo.$(O): y-api/y-echo.cpp y-api/y-echo.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

y-api/y-entity.$(O): y-api/y-entity.cpp y-api/y-entity.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

y-api/y-fft.$(O): y-api/y-fft.cpp y-api/y-fft.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

y-api/y-fluidsynth.$(O): y-api/y-fluidsynth.cpp y-api/y-fluidsynth.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

y-api/y-particle.$(O): y-api/y-particle.cpp y-api/y-particle.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

y-api/y-score-reader.$(O): y-api/y-score-reader.cpp y-api/y-score-reader.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

y-api/y-waveform.$(O): y-api/y-waveform.cpp y-api/y-waveform.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

rtaudio/RtAudio-dsound.$(O): CXXFLAGS += -D__WINDOWS_DS__
rtaudio/RtAudio-dsound.$(O): rtaudio/RtAudio.cpp rtaudio/RtAudio.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

rtaudio/RtAudio-jack.$(O): CXXFLAGS += -D__UNIX_JACK__
rtaudio/RtAudio-jack.$(O): rtaudio/RtAudio.cpp rtaudio/RtAudio.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

rtaudio/RtAudio-alsa.$(O): CXXFLAGS += -D__LINUX_ALSA__
rtaudio/RtAudio-alsa.$(O): rtaudio/RtAudio.cpp rtaudio/RtAudio.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

stk/Delay.$(O): stk/Delay.cpp stk/Delay.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

stk/DelayL.$(O): stk/DelayL.cpp stk/DelayL.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

stk/MidiFileIn.$(O): stk/MidiFileIn.cpp stk/MidiFileIn.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

stk/Stk.$(O): stk/Stk.cpp stk/Stk.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

core/dm-gfx.$(O) nehe/FreeType.$(O): CXXFLAGS += $(shell pkg-config --cflags freetype2)
nehe/FreeType.$(O): nehe/FreeType.cpp nehe/FreeType.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f *~ *# *.$(O) */*.$(O) main

