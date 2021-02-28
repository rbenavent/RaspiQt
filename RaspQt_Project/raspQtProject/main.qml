import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4


Window {
    id:rootWindow
    width: 800
    height: 600
    visible: true
    title: qsTr("Raspberry input/output TEST")
    Page{
        id:page
        anchors.fill: parent

        //membrete
        Rectangle{
            id:membrete
            width: rootWindow.width; height: rootWindow.height/7
            color:"#d3d3d3"
        }

        //barra menu
        Rectangle{
            width: rootWindow.width/10; height: rootWindow.height - membrete.height
            x:0
            y:membrete.height
            color:"lightblue"
            Column{
                width: parent.width
                spacing:10
                //anchors.centerIn: parent

                Button{
                    width: parent.width
                    text:qsTr("Casa")
                    font.bold: true
                }

                Button{
                    width: parent.width
                    text:qsTr("Porche")
                    font.bold: true
                }
                Button{
                    width: parent.width
                    text:qsTr("Timbre")
                    font.bold: true
                }
                Button{
                    width: parent.width
                    text:qsTr("In/Out")
                    font.bold: true
                }
            }
        }

/*        Column{
            spacing:10
            anchors.centerIn: parent
            Rectangle {
                width: 100; height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                SequentialAnimation on color {
                    loops: -1
                    ColorAnimation { to: "gray"; duration: 1000 }
                    ColorAnimation { to: "red"; duration: 1000 }
                }
                SequentialAnimation on width {
                    loops: -1
                    NumberAnimation { to: 50; duration: 1000 }
                    NumberAnimation { to: 100; duration: 1000 }
                }
            }
            Label{
                anchors.horizontalCenter: parent.horizontalCenter
                text:timer.counter.toString()
                Timer{
                    id:timer
                    property int counter:0
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: counter++
                }
            }


            Label{
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Press button to start a infinite loop")
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("START QML INFINITE LOOP")
                onClicked: {
                    for(;;){} //inifinite loop
                }
            }

            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("START C++ INFINITE LOOP")
                onClicked: {
                    Utils.infiniteLoop()
                }
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("C++ MUTEX DOUBLE LOCK")
                onClicked: {
                    Utils.mutexDoubleLock()
                }
            }

            Label{
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Test fast restart")
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("FORCE APP RESTART")
                onClicked: {
                    WDT.forceAppRestart()
                }
            }
            Label{
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Test Watch Dog Timer (WDT) ON/OFF")
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text:checked?qsTr("WDT ENABLED"):qsTr("WDT DISABLED")
                checkable: true
                checked: true
                onClicked: {
                    if(checked) WDT.startWdt()
                    else WDT.stopWdt()
                }
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("BLOCK UI 5500ms")
                onClicked: {
                    Utils.temporalBlockMainLoop(5500)
                }
            }

        }*/
        /*Column{
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            Label{
                width: parent.width
                wrapMode: Text.WordWrap
                visible:ENV.length>0
                text:qsTr("ENVIRONMENT INHERITANCE. WDT_TEST = ") + ENV
            }
            Label{
                width: parent.width
                wrapMode: Text.WordWrap
                visible:ARGLIST.length>0
                text:qsTr("PROCESS ARGUMENTS = ") + ARGLIST
            }
        }*/
    }
}
