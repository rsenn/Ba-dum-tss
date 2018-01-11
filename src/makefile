SNDDRV ?= alsa

TARGET := ba_dum_tss.$(SNDDRV)

SYSTEM := $(shell uname -s)

CXX = g++
INCLUDES = -Icore/ -Irtaudio/ -Istk/ -Ix-api/ -Iy-api/ -I/opt/local/include

ifeq ($(SYSTEM),Linux)
  FLAGS = $(INCLUDES) -c
  LIBS  = $(shell pkg-config --libs fluidsynth $(SNDDRV) gl glu freeglut) -lpthread -lm
else
  FLAGS = -D__MACOSX_CORE__ $(INCLUDES) -c
  LIBS  = -framework CoreAudio -framework CoreMIDI -framework CoreFoundation \
		   -framework IOKit -framework Carbon -framework OpenGL \
		   -framework GLUT -lstdc++ -lm
endif

OBJS = main.o core/dm-globals.o core/dm-audio.o core/dm-gfx.o core/bk-sim.o x-api/x-audio.o x-api/x-buffer.o x-api/x-fun.o \
	x-api/x-gfx.o x-api/x-loadlum.o x-api/x-loadrgb.o x-api/x-thread.o \
	x-api/x-vector3d.o y-api/y-charting.o y-api/y-echo.o y-api/y-entity.o \
	y-api/y-fft.o y-api/y-fluidsynth.o y-api/y-particle.o y-api/y-score-reader.o y-api/y-waveform.o \
	stk/Delay.o stk/DelayL.o stk/MidiFileIn.o \
	stk/Stk.o 

all: $(TARGET)

ba_dum_tss.jack: $(OBJS) rtaudio/RtAudio-jack.o
	$(CXX) -o $@ $^ $(LIBS)

ba_dum_tss.alsa: $(OBJS) rtaudio/RtAudio-alsa.o
	$(CXX) -o $@ $^ $(LIBS)

main.o: main.cpp
	$(CXX) -o $@ $(FLAGS) main.cpp

core/dm-globals.o: core/dm-globals.h core/dm-globals.cpp
	$(CXX) -o $@ $(FLAGS) core/dm-globals.cpp

core/dm-audio.o: core/dm-audio.h core/dm-audio.cpp
	$(CXX) -o $@ $(FLAGS) core/dm-audio.cpp

core/dm-gfx.o: core/dm-gfx.h core/dm-gfx.cpp
	$(CXX) -o $@ $(FLAGS) core/dm-gfx.cpp

core/bk-sim.o: core/bk-sim.h core/bk-sim.cpp
	$(CXX) -o $@ $(FLAGS) core/bk-sim.cpp

x-api/x-audio.o: x-api/x-audio.h x-api/x-audio.cpp
	$(CXX) -o $@ $(FLAGS) x-api/x-audio.cpp

x-api/x-buffer.o: x-api/x-buffer.h x-api/x-buffer.cpp
	$(CXX) -o $@ $(FLAGS) x-api/x-buffer.cpp

x-api/x-fun.o: x-api/x-fun.h x-api/x-fun.cpp
	$(CXX) -o $@ $(FLAGS) x-api/x-fun.cpp

x-api/x-gfx.o: x-api/x-gfx.h x-api/x-gfx.cpp
	$(CXX) -o $@ $(FLAGS) x-api/x-gfx.cpp

x-api/x-loadlum.o: x-api/x-loadlum.h x-api/x-loadlum.cpp
	$(CXX) -o $@ $(FLAGS) x-api/x-loadlum.cpp

x-api/x-loadrgb.o: x-api/x-loadrgb.h x-api/x-loadrgb.cpp
	$(CXX) -o $@ $(FLAGS) x-api/x-loadrgb.cpp

x-api/x-thread.o: x-api/x-thread.h x-api/x-thread.cpp
	$(CXX) -o $@ $(FLAGS) x-api/x-thread.cpp

x-api/x-vector3d.o: x-api/x-vector3d.h x-api/x-vector3d.cpp
	$(CXX) -o $@ $(FLAGS) x-api/x-vector3d.cpp

y-api/y-charting.o: y-api/y-charting.h y-api/y-charting.cpp
	$(CXX) -o $@ $(FLAGS) y-api/y-charting.cpp

y-api/y-echo.o: y-api/y-echo.h y-api/y-echo.cpp
	$(CXX) -o $@ $(FLAGS) y-api/y-echo.cpp

y-api/y-entity.o: y-api/y-entity.h y-api/y-entity.cpp
	$(CXX) -o $@ $(FLAGS) y-api/y-entity.cpp

y-api/y-fft.o: y-api/y-fft.h y-api/y-fft.cpp
	$(CXX) -o $@ $(FLAGS) y-api/y-fft.cpp

y-api/y-fluidsynth.o: y-api/y-fluidsynth.h y-api/y-fluidsynth.cpp
	$(CXX) -o $@ $(FLAGS) y-api/y-fluidsynth.cpp

y-api/y-particle.o: y-api/y-particle.h y-api/y-particle.cpp
	$(CXX) -o $@ $(FLAGS) y-api/y-particle.cpp

y-api/y-score-reader.o: y-api/y-score-reader.h y-api/y-score-reader.cpp
	$(CXX) -o $@ $(FLAGS) y-api/y-score-reader.cpp

y-api/y-waveform.o: y-api/y-waveform.h y-api/y-waveform.cpp
	$(CXX) -o $@ $(FLAGS) y-api/y-waveform.cpp

rtaudio/RtAudio-jack.o: FLAGS += -D__UNIX_JACK__
rtaudio/RtAudio-jack.o: rtaudio/RtAudio.h rtaudio/RtAudio.cpp
	$(CXX) -o $@ $(FLAGS) rtaudio/RtAudio.cpp

rtaudio/RtAudio-alsa.o: FLAGS += -D__LINUX_ALSA__
rtaudio/RtAudio-alsa.o: rtaudio/RtAudio.h rtaudio/RtAudio.cpp
	$(CXX) -o $@ $(FLAGS) rtaudio/RtAudio.cpp

stk/Delay.o: stk/Delay.h stk/Delay.cpp
	$(CXX) -o $@ $(FLAGS) stk/Delay.cpp

stk/DelayL.o: stk/DelayL.h stk/DelayL.cpp
	$(CXX) -o $@ $(FLAGS) stk/DelayL.cpp

stk/MidiFileIn.o: stk/MidiFileIn.h stk/MidiFileIn.cpp
	$(CXX) -o $@ $(FLAGS) stk/MidiFileIn.cpp

stk/Stk.o: stk/Stk.h stk/Stk.cpp
	$(CXX) -o $@ $(FLAGS) stk/Stk.cpp

clean:
	rm -f *~ *# *.o */*.o main

