import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import QtMultimedia 5.4

//video -> http://192.168.0.148/mjpeg/1
//image -> http://192.168.0.148/jpg

Item {
    id: casa
    visible: true
    objectName: "timbre"

    Pane {
        id: pane
        anchors.fill: parent


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
            interval: 1000
            running: true
            repeat: true
            onTriggered:  {
                image1.cache =false;
                image1.source = "http://192.168.0.148/jpg";
            }
        }

    } // Pane
    Component.onCompleted: timercam.start()
}
