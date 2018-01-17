# Install script for directory: /phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/eicsmear/erhic" TYPE FILE FILES
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/BeamParticles.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/DisKinematics.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventBase.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventDis.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventDjangoh.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventDpmjet.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventFactory.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventGmcTrans.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventMC.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventMCFilterABC.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventMilou.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventPepsi.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventPythia.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/EventRapgap.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/File.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/Forester.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/Kinematics.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/Particle.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/ParticleIdentifier.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/ParticleMC.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/Pid.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/VirtualEvent.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/erhic/VirtualParticle.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/eicsmear" TYPE FILE FILES "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/functions.h")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/eicsmear/smear" TYPE FILE FILES
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/Acceptance.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/Bremsstrahlung.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/Detector.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/Device.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/Distributor.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/EventS.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/EventSmear.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/EventDisFactory.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/FormulaString.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/functions.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/ParticleID.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/ParticleMCS.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/PerfectID.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/PlanarTracker.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/RadialTracker.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/Smear.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/Smearer.h"
    "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/include/eicsmear/smear/Tracker.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libeicsmear.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libeicsmear.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libeicsmear.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/build/libeicsmear.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libeicsmear.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libeicsmear.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libeicsmear.so")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/phenix/u/spjeffas/LQGENEP/eic-smear-1.0.3/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
