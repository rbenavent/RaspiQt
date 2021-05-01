import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

//import Qt5GStreamer  1.0
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

        /*Video {
            id: cam1Stream
            x: 100
            y: 0
            width: 600
            height: 400
            source: "http://localhost:8081"
            autoPlay: true
            opacity: 1.0
            fillMode: Image.Stretch
            muted: false
        }*/

        /*Video {
            id: cam1Stream

            width: parent.width
            height: parent.height
            source: "http://192.168.0.23:8081"
            autoPlay: true
            opacity: 1.0
            fillMode: Image.Stretch
            muted: false
        }*/

        /*MediaPlayer {
            id: videoPlayer
            source: "http://localhost:8081"
            muted: true
            autoPlay: true
        }*/

        /*VideoOutput {
            id: camera1
            x: 0
            y: 100
            width: 600
            height: 400
            anchors.horizontalCenter: parent.horizontalCenter
            source: "http://192.168.0.23:8081"
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
        Rectangle {
            //x:100
            //y:0
            width: 800
            height: 600

            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: bAbrirCerrarGaraje.width

            color: "black"

            MediaPlayer {
                id: player
                source: "rtsp://192.168.0.23:8554/stream"
                autoPlay: true
            }

            VideoOutput {
                id: videoOutput
                source: player
                anchors.fill: parent
                rotation: 180
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
