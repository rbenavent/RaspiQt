QT += core quick #webkit
#//QT += quickcontrols2
#//QT += mqtt

CONFIG += c++17
#CONFIG += link_pkgconfig
#PKGCONFIG += Qt5GStreamer-1.0
#QT += webkit

#CONFIG += link_pkgconfig
#PKGCONFIG += gstreamer-1.0 #glib-2.0 gobject-2.0 gstreamer-app-1.0 gstreamer-pbutils-1.0

SOURCES += main.cpp \
    utils.cpp

HEADERS += utils.h

RESOURCES += qml.qrc

include($$PWD/../io/io.pri)
include($$PWD/../mqttclient/mqttclient.pri)


DEFINES
