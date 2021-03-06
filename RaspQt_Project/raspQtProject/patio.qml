import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import QtMultimedia 5.4

import mqttclient.mqttclient   1.0

//http://192.168.0.148/mpej1/1

Item {
    id: patio
    visible: true
    objectName: "patio"

    property string taPorche:""

    Pane {
        id: pane
        anchors.fill: parent

        Image{
            anchors.fill: parent
            source: "images/patio.png"
        }
        /*Rectangle {
            //x:100
            //y:0
            width: 800
            height: 600

            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 100

            color: "black"

            MediaPlayer {
                id: player
                source: "rtsp://192.168.0.153:8554/mjpeg/1"
                autoPlay: true
            }

            VideoOutput {
                id: videoOutput
                source: player
                anchors.fill: parent
                //rotation: 180
            }
        }*/

    } // Pane

    Text {
        id: ta_Porche
        text: qsTr("Tª:")
        x:20
        y:15
        color:  "WHITE";
        font.pixelSize: parent.height/30
        font.bold: true
    }

    Connections{
        target: MqttClient
        enabled: visible
        onSgnTemperaturaPorche: {
            taPorche = msg.substring(0,1)
            if(taPorche==="1")ta_Porche.color="BLUE"
            else if(taPorche==="2")ta_Porche.color="GREEN"
            else if(taPorche==="3")ta_Porche.color="YELLOW"
            else if(taPorche==="4")ta_Porche.color="RED"
            else ta_Porche.color="BLACK"
                ta_Porche.text=qsTr("Tª: ")+msg+"ºC"
        }
    }
}
