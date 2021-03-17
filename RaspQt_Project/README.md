# for Qt & QML


## HOW IT WORKS:


## USAGE:


## Tested OS:
- Ubuntu 20.04


## Tested main loop locks:
- QML js infinite loop
- C++ infinite loop
- C++ mutex double lock


## Restart estrategy
- Linux : exec (application arguments are kept)


## Delayed restart estrategy
- Linux : bash


## License
Qt & QML is released under the terms of the **GNU LGPL v3 License**. Full details in `license.txt` file.


##Dependencies for QML
- qtdeclarative5-*
- qml-module-qtquick*
- qtquick1-*
- qtquickcontrols5-*
- qml-module-qtquick2
- apt-get install libqt5multimedia5-plugins qml-module-qtmultimedia
- apt-get install qtbase5-private-dev libqt5websockets5-dev

/******for webglplugin******/
- apt-get install libfontconfig1-dev  (fail in make qtwebplugin)
>>dowload qtwebplugin:    qtwebglplugin-everywhere-src-5.12.10  from   https://download.qt.io/official_releases/qt
>>unzip and run: qmake  and   make
after make, cpying the "libqwebgl.so" into root@raspberrypi:/usr/lib/arm-linux-gnueabihf/qt5/plugins/platforms#
to run app with webgl: ./your-qt-application -platform webgl:port=8998   (from QtCreator Projects -> Command line Argument: -platform webgl:port=8998)


╭------┬---------┬----------------------------┬-------------------╮
|      |         | QtQuick.Controls,          |                   |
|      |         | QtQuick.Controls.Material, |                   |
|  Qt  | QtQuick | QtQuick.Controls.Universal,| Qt.labs.calendar, |
|      |         | QtQuick.Templates          | Qt.labs.platform  |
|      |         |                            |                   |
├------┼---------┼----------------------------┼-------------------┤
| 5.7  |   2.7   |          2.0               |        1.0        |
| 5.8  |   2.8   |          2.1               |        1.0        |
| 5.9  |   2.9   |          2.2               |        1.0        |
| 5.10 |   2.10  |          2.3               |        1.0        |
| 5.11 |   2.11  |          2.4               |        1.0        |
| 5.12 |   2.12  |          2.12              |        1.0        |
╰------┴---------┴----------------------------┴-------------------╯
