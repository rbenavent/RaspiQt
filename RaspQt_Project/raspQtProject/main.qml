import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4

import "qrc:/Widgets"

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
            width: rootWindow.width
            height: rootWindow.height/7
            color:"#d3d3d3"

            WeatherWidget{
                id:ww
                height: membrete.height//root.height/5
                width: membrete.width//10
                //anchors.top: parent.top
                //anchors.topMargin: 0
                x:0//parent.width/20
                y:0
                visible: true

                Component.onCompleted: ww.startMonitoring()
            }

        }

        //barra menu
        Rectangle{
            id:menuBar
            width: rootWindow.width/10;
            height: rootWindow.height - membrete.height
            x:0
            y:membrete.height
            color:"lightblue"            

            Column{
                width: parent.width
                spacing:15
                //anchors.centerIn: parent                

                Button{
                    width: parent.width
                    height: parent.height/6
                    text:qsTr("Casa")
                    font.bold: true
                    onClicked: contentFrame.replace("qrc:/casa.qml")//view.view=1
                }
                Button{
                    width: parent.width
                    height: parent.height/6
                    text:qsTr("Porche")
                    font.bold: true
                    onClicked: contentFrame.replace("qrc:/patio.qml")
                }
                Button{
                    width: parent.width
                    height: parent.height/6
                    text:qsTr("Timbre")
                    font.bold: true
                    onClicked: contentFrame.replace("qrc:/timbre.qml")
                }
                Button{
                    width: parent.width
                    height:parent.height/6
                    text:qsTr("Garaje")
                    font.bold: true
                    onClicked: contentFrame.replace("qrc:/garaje.qml")
                }
                Button{
                    width: parent.width
                    //height: parent.height/6
                    text:qsTr("In/Out")
                    font.bold: true
                    onClicked: contentFrame.replace("qrc:/testio.qml")//view.moveItem(thirdPage,firstPage)
                }
                Button{
                    width: parent.width
                    //height: parent.height/6
                    text:qsTr("Salirapp")
                    font.bold: true
                    onClicked:{
                        //QmlUtils.restart(0);
                        Qt.quit()
                    }
                }
            }

        }

        Rectangle{
            width: parent.width - menuBar.width
            height: parent.height - membrete.height
            x:menuBar.width
            y:membrete.height
            border.color: "black"
            border.width: 1

            StackView{
                //width: parent.width - menuBar.width
                //height: parent.height - membrete.height
                //x:menuBar.width
                //y:membrete.height
                height: parent.height
                width: parent.width
                id: contentFrame
                initialItem: Qt.resolvedUrl("qrc:/casa.qml")
            }

            Component.onCompleted: {
                contentFrame.replace("qrc:/casa.qml")
            }
        }


        /*SwipeView {
            id: view

            currentIndex: 0
            anchors.fill: parent

            Item {
                id: firstPage
            }
            Item {
                id: secondPage
            }
            Item {
                id: thirdPage
            }
        }

        PageIndicator {
            id: indicator

            count: view.count
            currentIndex: view.currentIndex

            anchors.bottom: view.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }*/















        //StackView de ventanas principal
        /*StackView {
            id: stackViewMain
            anchors.fill: parent
            focus: true

            Component.onCompleted:{
                //if(mainPantalla15)cargarBannerLang()
                //ini_page()
            }
            onCurrentItemChanged: {
                if (currentItem === null)
                    console.debug("Vaciada stackViewMain")
                else
                    console.info("[USUARIO] VENTANA ACTUAL: " + currentItem.objectName)
            }

            pushEnter: Transition {
                PropertyAnimation {
                    property: "scale"
                    from: 0
                    to: 1
                    duration: 300
                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "scale"
                    from: 1
                    to: 0
                    duration: 300
                }
            }
            popEnter: Transition {
                PropertyAnimation {
                    property: "scale"
                    from: 0
                    to: 1
                    duration: 300
                }
            }
            popExit: Transition {
                PropertyAnimation {
                    property: "scale"
                    from: 1
                    to: 0
                    duration: 300
                }
            }
            replaceEnter: Transition {
                PropertyAnimation {
                    property: "scale"
                    from: 0
                    to: 1
                    duration: 300
                }
            }

            replaceExit: Transition {
                PropertyAnimation {
                    property: "scale"
                    from: 1
                    to: 0
                    duration: 300
                }
            }
        }*/
    }
}
