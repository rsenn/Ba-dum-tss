project(Ba-dum-tss)

cmake_minimum_required(VERSION 2.8)

include( FindPkgConfig )
#include( UsePkgConfig )

include( FindOpenGL )
include( FindGLUT )
include( FindALSA )

pkg_search_module(FLUIDSYNTH fluidsynth)

include( CheckLibraryExists )
check_library_exists(pthread pthread_create "" LIBPTHREAD_FOUND)

if(LIBPTHREAD_FOUND)
  set(LIBPTHREAD pthread)
endif() 

message("LIBPTHREAD: ${LIBPTHREAD}")

add_definitions(-D__LINUX_ALSA__)

add_definitions(-DSOUNDFONT=\"src/data/sfonts/rocking8m11e\ copy.sf2\")


include_directories(
    Ba-dum-tss/src
    src/core
    src/rtaudio
    src/stk
    src/x-api
    src/y-api
    ${FLUIDSYNTH_INCLUDE_DIR}
)

add_executable(ba_dum_tss
    src/main.cpp
    src/core/bk-sim.cpp
    src/core/dm-audio.cpp
    src/core/dm-gfx.cpp
    src/core/dm-globals.cpp
    src/rtaudio/RtAudio.cpp
    src/stk/Delay.cpp
    src/stk/DelayL.cpp
    src/stk/MidiFileIn.cpp
    src/stk/Stk.cpp
    src/x-api/x-audio.cpp
    src/x-api/x-buffer.cpp
    src/x-api/x-fun.cpp
    src/x-api/x-gfx.cpp
    src/x-api/x-loadlum.cpp
    src/x-api/x-loadrgb.cpp
    src/x-api/x-thread.cpp
    src/x-api/x-vector3d.cpp
    src/y-api/y-charting.cpp
    src/y-api/y-echo.cpp
    src/y-api/y-entity.cpp
    src/y-api/y-fft.cpp
    src/y-api/y-fluidsynth.cpp
    src/y-api/y-particle.cpp
    src/y-api/y-score-reader.cpp
    src/y-api/y-waveform.cpp
)

target_link_libraries(ba_dum_tss 
  ${FLUIDSYNTH_LIBRARIES}
  ${ALSA_LIBRARIES}
  ${GLUT_LIBRARIES}
  ${OPENGL_LIBRARIES}
  ${X11_LIBRARIES}
  ${LIBPTHREAD}
)
