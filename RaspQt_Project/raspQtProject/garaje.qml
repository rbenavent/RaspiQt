import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

import QtMultimedia 5.4

import mqttclient.mqttclient   1.0
import io.io    1.0

//http://192.168.0.148/mpej1/1

Item {
    id: patio
    visible: true
    objectName: "garaje"

    Pane {
        id: pane
        anchors.fill: parent

        /*MediaPlayer {
            id: videoPlayer
            source: "http://192.168.0.148/mjpeg/1"
            muted: true
            autoPlay: true
        }

        VideoOutput {
            id: camera1
            x: 0
            y: 100
            width: 600
            height: 400
            anchors.horizontalCenter: parent.horizontalCenter
            source: videoPlayer
        }*/

        Button {
            id: bAbrirCerrarGaraje
            text: qsTr("Abrir\nPuerta")
            width: parent.width/10<100? 100 : parent.width/10
            height: parent.height/10<100? 100 : parent.height/10
            onClicked:{
                Io.outChange(0, true)
                quitarPuerta.start()
            }
        }
    } // Pane

    Timer{
        id:quitarPuerta
        running: false
        repeat:false
        interval: 1000
        onTriggered:{
            Io.outChange(0, false)
            quitarPuerta.stop()
        }
    }
}
