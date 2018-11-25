project(ba-dum-tss)

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
if(MINGW OR WIN32)
  #add_definitions(-D__WINDOWS_MM__=1 -D__WINDOWS_PTHREAD__=1)
  add_definitions(-D__WINDOWS_DS__=1 -D__WINDOWS_PTHREAD__=1)
  link_libraries(dsound winmm ole32)
endif()

if(LINUX)
  add_definitions(-D__LINUX_ALSA__ -D__PLATFORM_LINUX__)
endif()


string(TOLOWER "share/${PROJECT_NAME}" RDATADIR)
set(DATADIR "${RDATADIR}" CACHE STRING "Data dir" FORCE)

#add_definitions(-DSOUNDFONT=\"../Ba-dum-tss/src/data/sfonts/rocking8m11e\ copy.sf2\")
#add_definitions(-DTRUETYPEFONT=\"../Ba-dum-tss/src/data/font/arialb.ttf\")

  #option(IDATADIR "Install data dir" "${CMAKE_INSTALL_PREFIX}/${DATADIR}")
  set(IDATADIR "${CMAKE_INSTALL_PREFIX}/${DATADIR}" CACHE STRING "Install data dir" FORCE)
  #add_definitions(-DDATADIR=\"${IDATADIR}\")
  
  set(SOUNDFONT_FILE "sfonts/rocking8m11e_copy.sf2")
  set(TRUETYPE_FILE "font/arialb.ttf")

message("SoundFont file: ${IDATADIR}/${SOUNDFONT_FILE}")
message("TrueType font: ${IDATADIR}/${TRUETYPE_FILE}")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DSOUNDFONT=\"\\\"${IDATADIR}/${SOUNDFONT_FILE}\\\"\"")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DTRUETYPEFONT=\"\\\"${IDATADIR}/${TRUETYPE_FILE}\\\"\"")

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
  ${FLUIDSYNTH_LIBS}
  ${ALSA_LIBRARIES}
  ${FREETYPE_LIBRARY_RELEASE}
  ${GLUT_LIBRARIES}
  ${OPENGL_LIBRARIES}
  ${X11_LIBRARIES}
  ${LIBPTHREAD}
  ${Boost_FILESYSTEM_LIBRARY}
  ${Boost_SYSTEM_LIBRARY}
)

install(TARGETS ba_dum_tss DESTINATION bin)
install(DIRECTORY 
  "${CMAKE_SOURCE_DIR}/src/data/font" 
  "${CMAKE_SOURCE_DIR}/src/data/sfonts" 
  "${CMAKE_SOURCE_DIR}/src/data/texture" 
  DESTINATION "${DATADIR}"
)

install(FILES "${CMAKE_SOURCE_DIR}/src/data/${SOUNDFONT_FILE}" DESTINATION "${RDATADIR}/sfont")
install(FILES "${CMAKE_SOURCE_DIR}/src/data/${TRUETYPE_FILE}" DESTINATION "${RDATADIR}/font")