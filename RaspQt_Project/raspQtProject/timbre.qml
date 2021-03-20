import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import QtMultimedia 5.4

import mqttclient.mqttclient   1.0

//video -> http://192.168.0.148/mjpeg/1
//image -> http://192.168.0.148/jpg

Item {
    id: casa
    visible: true
    objectName: "timbre"

    width: 640
    height: 360

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
               width: 600
               height: 400
               anchors.horizontalCenter: parent.horizontalCenter
               source: videoPlayer
           }*/
        /*Video {
            id: cam1Stream
            x: 0
            y: 0
            width: 600
            height: 400
            source: "http://192.168.0.148/mjpeg/1"
            autoPlay: true
            opacity: 1.0
            fillMode: Image.Stretch
            muted: false
        }*/


        /*Camera {
                id: camera
                captureMode: Camera.CaptureStillImage

                imageCapture {
                    onImageCaptured: {
                        photoPreview.source = cam14era
                        stillControls.previewAvailable = true
                        cameraUI.state = "PhotoPreview"
                    }
                }

                videoRecorder {
                     resolution: "1920x1080"
                     frameRate: 30
                }

            }*/

        /*Rectangle {
            width: 800
            height: 600
            color: "black"*/

            /*MediaPlayer {
                 id: videoPlayer
                 source: "http://192.168.0.148/mjpeg/1"
                 //muted: true
                 autoPlay: true
                 //autoLoad: true

             }

             VideoOutput {
                 id: camera1
                 //width: 1920
                 //height: 1080
                 anchors.fill:parent
                 source: videoPlayer
             }*/


             /*Video {
                     id: cam1Stream

                     width: parent.width
                     height: parent.height
                     source: "http://192.168.0.148/mjpeg/1"
                     autoPlay: true
                     opacity: 1.0
                     fillMode: Image.Stretch
                     muted: false
                 }
        }*/





        Image{
            id:image1
            anchors.fill: parent
            width: parent.width
            height: parent.height
        }

        Timer {
            id:timercam
            interval: 2000
            running: true
            repeat: true
            onTriggered:  {
                image1.cache =false;
                image1.source = "http://192.168.0.148/jpg";
            }
        }

        Button {
            id: b0Out1
            text: qsTr("resetCam")
            //onClicked:MqttClient.publish_topic("resetcamaratimbre")
            onClicked:{
                MqttClient.publish_topic("resetcamaratimbre","1")
                //MqttClient.publish_topic("1")
            }
        }


    } // Pane

    Component.onCompleted: {

        timercam.start()
    }
}
