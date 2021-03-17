QT += quick
//QT += quickcontrols2
//QT += mqtt

CONFIG += c++17

SOURCES += main.cpp \
    utils.cpp

HEADERS += utils.h

RESOURCES += qml.qrc

include($$PWD/../io/io.pri)
include($$PWD/../mqttclient/mqttclient.pri)

DEFINES
