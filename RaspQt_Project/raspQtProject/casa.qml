import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4


Item {
    id: casa
    visible: true
    objectName: "casa"

    Pane {
        id: pane
        anchors.fill: parent

    Image{
        anchors.fill: parent
        //source: "/home/pi/Qt_projects/RaspQt_Project/raspQtProject/images/casa_1.png"
        source: "images/casa_1.png"
    }




    } // Pane


}
