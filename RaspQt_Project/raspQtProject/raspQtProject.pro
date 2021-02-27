QT += quick

CONFIG += c++17

SOURCES += main.cpp \
    utils.cpp

HEADERS += utils.h

RESOURCES += qml.qrc

#USE MAIN LOOP WDT.
include($$PWD/../io/io.pri)
