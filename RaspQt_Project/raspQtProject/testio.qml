import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

import "qrc:/Widgets"
import "qrc:/Complementos"

RowLayout {
    property alias stIndIn: stIn.active
    property alias stIndOut: stOut.active
    property int posIO: 0
    property int fontSize: 12

    id: customRow
    objectName: "testIO"

    Label {
        id: tIn
        text: qsTr("IN ").concat(posIO)
        Layout.fillWidth: true
        font.pixelSize: fontSize
    }
    StatusIndicator {
        id: stIn
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "green"
    }

    Label {
        id: tOut
        text: qsTr("OUT ").concat(posIO)
        Layout.fillWidth: true
        font.pixelSize: fontSize
    }
    StatusIndicator {
        id: stOut
        Layout.fillHeight: true
        Layout.fillWidth: true
        /*active:{
            if(true)stOut.color = "yellow"
        }*/
        color: "green"
    }

    Button {
        id: b1Out1
        text: qsTr("1")
        onClicked: changeOut(false)
    }

    Button {
        id: b0Out1
        text: qsTr("0")
        onClicked: changeOut(true)
    }

    /*function changeOut(st) {
        IOManager.outChange(posIO, st)
    }*/
}
