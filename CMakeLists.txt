cmake_minimum_required(VERSION 3.10)
project(solver VERSION 1.0.0 LANGUAGES CXX)

set(Qt5_DIR $ENV{QT_DIR_X64})
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt5 REQUIRED Qml Quick Gui)

qt5_add_resources(qml_QRC src/qml.qrc)

set(SOURCE ${SOURCE} src/main.cpp src/TaskSolver.cpp src/InputKeysHolder.cpp include/TaskSolver.h include/InputKeysHolder.h)

add_executable(solver ${SOURCE} ${qml_QRC})

target_include_directories(solver PRIVATE include/)
target_link_libraries(solver Qt5::Qml Qt5::Quick)
