import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

import io.io    1.0



Item {
    id: testIO
    visible: true
    objectName: "testIO"

    Pane {
        id: pane
        anchors.fill: parent


        SwipeView {
            id: swipeView
            width: parent.width
            height: parent.height-tabBar.height*2.5
            currentIndex: tabBar.currentIndex
            y:parent.height/10

            //property var titles: ["1","2","3","4"]
            //Repeater{
            GroupBox {
                id: sInputs
                title: qsTr("INPUTS");


                GridLayout{
                    id:grid
                    Layout.alignment: Qt.AlignTop

                    width: parent.width
                    height: parent.height

                    x:0
                    columnSpacing: 0
                    rowSpacing: 0
                    columns: 4

                    ColumnLayout {
                        id: rowLayout1
                        //anchors.fill: parent
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: tIn1
                            text: qsTr("IN ").concat("1")
                            Layout.fillWidth: true
                            font.pixelSize: 10
                        }
                        StatusIndicator {
                            id: stIn1
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "green"
                        }
                    }
                    ColumnLayout {
                        id: rowLayout2
                        //anchors.fill: parent
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: tIn2
                            text: qsTr("IN ").concat("2")
                            Layout.fillWidth: true
                            font.pixelSize: 10
                        }
                        StatusIndicator {
                            id: stIn2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "green"
                        }
                    }
                    ColumnLayout {
                        id: rowLayout3
                        //anchors.fill: parent
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: tIn3
                            text: qsTr("IN ").concat("3")
                            Layout.fillWidth: true
                            font.pixelSize: 10
                        }
                        StatusIndicator {
                            id: stIn3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "green"
                        }
                    }
                    ColumnLayout {
                        id: rowLayout4
                        //anchors.fill: parent
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: tIn4
                            text: qsTr("IN ").concat("4")
                            Layout.fillWidth: true
                            font.pixelSize: 10
                        }
                        StatusIndicator {
                            id: stIn4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "green"
                        }
                    }
                }
            } // GroupBox


            GroupBox {
                id:sOutputs
                title: qsTr("OUTPUTS");
                RowLayout{
                    id:layoutOutputs
                    Layout.alignment: Qt.AlignTop

                    width: parent.width
                    height: parent.height

                    ColumnLayout {
                        id: rowOutL1
                        //anchors.fill: parent
                        Layout.alignment: Qt.AlignTop

                        Label {
                            id: tOut1
                            text: qsTr("OUT ")//.concat(posIO)
                            Layout.fillWidth: true
                            font.pixelSize: 10
                        }
                        StatusIndicator {
                            id: stOut1
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            color: "green"
                        }

                        Button {
                            id: b1Out1
                            text: qsTr("1")
                            onClicked:Io.outChange(0, true)
                        }

                        Button {
                            id: b0Out1
                            text: qsTr("0")
                            onClicked:Io.outChange(0, false)
                        }
                    }


                    ColumnLayout {
                        id: rowOutL2
                        //anchors.fill: parent
                        Layout.alignment: Qt.AlignTop

                        Label {
                            id: tOut2
                            text: qsTr("OUT ")//.concat(posIO)
                            Layout.fillWidth: true
                            font.pixelSize: 10
                        }
                        StatusIndicator {
                            id: stOut2
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            color: "green"
                        }

                        Button {
                            id: b1Out2
                            text: qsTr("1")
                            onClicked:Io.outChange(1, true)
                        }

                        Button {
                            id: b0Out2
                            text: qsTr("0")
                            onClicked:Io.outChange(1, false)
                        }
                    }


                }//RowLayout OUTPUTS
            }// GroupBox
        }//SwipeView

        // Barra de pestañas
        TabBar {
            id: tabBar
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height/5
            width: parent.width-4
            x:2
            currentIndex: swipeView.currentIndex
            TabButton {
                text: qsTr("INPUTS")
            }
            TabButton {
                text: qsTr("OUTPUTS")
            }
        } // TabBar
    } // Pane

    Connections {
        target: Io
        onSgnInputs:{
            stIn1.active = value & 0x01
            stIn2.active = value & 0x02
            stIn3.active = value & 0x04
            stIn4.active = value & 0x08
        }
        onSgnOutputs:{//feedback outputs state
            stOut1.active = value & 0x01
            stOut2.active = value & 0x02
        }
    }

}
