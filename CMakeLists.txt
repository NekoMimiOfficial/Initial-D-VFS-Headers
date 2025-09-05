cmake_minimum_required(VERSION 3.5.0)
project(IDSS-VFS-headers VERSION 1.0.2 LANGUAGES C CXX ASM)

set (CMAKE_CXX_STANDARD_REQUIRED 20)
set (CMAKE_CXX_STANDARD 20)

set (FullOutputDir "${CMAKE_SOURCE_DIR}/objects")
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${FullOutputDir}/static_libs")
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY "${FullOutputDir}")
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY "${FullOutputDir}")

include_directories(header)
include_directories(source)

add_library(IDSSVfs SHARED
  ./source/assembly.S
  ./source/hashtools.cpp
  ./source/typeCheck.cpp
  ./source/extractANA.cpp
  ./source/extractXBB.cpp
)

set_target_properties(IDSSVfs PROPERTIES
  VERSION ${PROJECT_VERSION}
  SOVERSION ${PROJECT_VERSION_MAJOR}
  PUBLIC_HEADER ./headers/XBB.hpp
  PUBLIC_HEADER ./headers/ANA.hpp
  PUBLIC_HEADER ./headers/hashtools.hpp
  PUBLIC_HEADER ./headers/typeCheck.hpp
  PUBLIC_HEADER ./headers/extractANA.hpp
  PUBLIC_HEADER ./headers/extractXBB.hpp
)
