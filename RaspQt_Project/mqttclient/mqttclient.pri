QT += core network
#QT += websockets en el main.pri
CONFIG += NO_UNIT_TESTS
include($$PWD/qmqtt/src/mqtt/qmqtt.pri)
HEADERS += $$PUBLIC_HEADERS $$PRIVATE_HEADERS

DEFINES += QT_BUILD_QMQTT_LIB # QT_NO_CAST_TO_ASCII QT_NO_CAST_FROM_ASCII QT_STATIC

HEADERS +=$$PWD/qmqtt/src/mqtt/qmqtt.h\
$$PWD/qmqtt/src/mqtt/qmqtt_global.h

HEADERS += \
    $$PWD/mqttclient.h 

SOURCES += \
    $$PWD/mqttclient.cpp

RESOURCES += \
    $$PWD/SSL_CERTS.qrc
   
INCLUDEPATH += $$PWD $$PWD/qmqtt/src/mqtt/

OTHER_FILES += $$PWD/qmqtt/README.md \
    $$PWD/qmqtt/LICENSE \
    $$PWD/qmqtt/LEEME.txt
