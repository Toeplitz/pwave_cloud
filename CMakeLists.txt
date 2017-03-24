cmake_minimum_required (VERSION 2.6)
project (pwave_cloud)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/)                                                                                                                                   
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/)                                                                                                                                   
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/)

include_directories("${PROJECT_SOURCE_DIR}")


add_subdirectory(src/server/)
add_subdirectory(src/client/)


