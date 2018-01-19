project(Ba-dum-tss)

cmake_minimum_required(VERSION 2.8)

include( FindPkgConfig )
#include( UsePkgConfig )

include( FindOpenGL )
include( FindGLUT )
include( FindALSA )

pkg_search_module(FLUIDSYNTH fluidsynth)

find_package(Boost COMPONENTS filesystem system)

if(Boost_LIBRARY_DIRS)
  link_directories(${Boost_LIBRARY_DIRS})
endif()
if(Boost_INCLUDE_DIR)
  include_directories(Boost_INCLUDE_DIR)
endif()
if(Boost_FILESYSTEM_LIBRARY)
  add_definitions(-DHAVE_BOOST_FILESYSTEM=1)
endif()

include( CheckLibraryExists )
check_library_exists(pthread pthread_create "" LIBPTHREAD_FOUND)

if(LIBPTHREAD_FOUND)
  set(LIBPTHREAD pthread)
endif() 

include(FindFreetype)

include_directories(${FREETYPE_INCLUDE_DIR_freetype2} ${FREETYPE_INCLUDE_DIR_ft2build})

message("LIBPTHREAD: ${LIBPTHREAD}")

add_definitions(-D__LINUX_ALSA__)

add_definitions(-DSOUNDFONT=\"../Ba-dum-tss/src/data/sfonts/rocking8m11e\ copy.sf2\")
add_definitions(-DTRUETYPEFONT=\"../Ba-dum-tss/src/data/font/arialb.ttf\")


include_directories(
    Ba-dum-tss/src
    src/core
    src/rtaudio
    src/stk
    src/x-api
    src/y-api
    src/nehe
    ${FLUIDSYNTH_INCLUDE_DIR}
)

file(GLOB HEADERS src/*/*.h)
#file(GLOB SOURCES src/*/*.cpp)

set(SOURCES
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
    src/nehe/FreeType.cpp
)

add_executable(ba_dum_tss
    src/main.cpp
    ${SOURCES}
    ${HEADERS}
)

target_link_libraries(ba_dum_tss 
  ${FLUIDSYNTH_LIBRARIES}
  ${ALSA_LIBRARIES}
  ${FREETYPE_LIBRARY_RELEASE}
  ${GLUT_LIBRARIES}
  ${OPENGL_LIBRARIES}
  ${X11_LIBRARIES}
  ${LIBPTHREAD}
  ${Boost_FILESYSTEM_LIBRARY}
  ${Boost_SYSTEM_LIBRARY}
)
