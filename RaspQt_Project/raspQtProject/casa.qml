import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import QtMultimedia 5.4

import mqttclient.mqttclient   1.0

//http://192.168.0.148/mpej1/1

Item {
    id: casa
    visible: true
    objectName: "casa"

    property string taPorche:""

    Pane {
        id: pane
        anchors.fill: parent

        Image{
            anchors.fill: parent
            source: "images/casa_1.png"
        }
    } // Pane

    Text {
        id: ta_Porche
        text: qsTr("Tª:")
        x:0
        y:0
        color:  "WHITE";
        font.pixelSize: parent.height/30
        font.bold: true
    }
    /*void msgReceived(const QString& msg);
    void msgTemperaturaPorche(const QString& msg);
    void msgTemperaturaComedor(const QString& msg);
    void msgTemperaturaCocina(const QString& msg);*/

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
                ta_Porche.text=qsTr("Tª: ")+msg
        }
    }
}
