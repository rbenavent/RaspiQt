import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import QtMultimedia 5.4

//http://192.168.0.148/mpej1/1


Item {
    id: casa
    visible: true
    objectName: "casa"

    Pane {
        id: pane
        anchors.fill: parent

        Image{
            anchors.fill: parent
            source: "images/casa_1.png"
        }
    } // Pane
}
