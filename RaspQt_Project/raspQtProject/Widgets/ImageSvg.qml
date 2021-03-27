import QtQuick 2.0
import QtQuick.Window 2.11
Image {
  //  property int ppi: Screen.pixelDensity*25.4

    id: img
    antialiasing: true
    onWidthChanged: timer.restart() //Qt.callLater(resize)
    onHeightChanged: timer.restart() //Qt.callLater(resize)
    asynchronous : true
    //cache:false
    smooth : true
    property int originalx:1
    property int originaly:1
    property real orginalScale: originalx/originaly
    // fillMode: Image.PreserveAspectFit
    Timer{
        id:timer
        interval: 200
        repeat: false
        running: false
        onTriggered:{
            resize()
        }
    }
    onSourceChanged: {
        originalx=1
        originaly=1
    }
    onStatusChanged: {
        if(status==Image.Ready ){
            Qt.callLater(resize)
        }
    }

    function resize(){
        if(originalx==1 &&originaly==1){
            originalx=sourceSize.height
            originaly=sourceSize.width
        }
        sourceSize.height= height
        sourceSize.width= width
        //  console.log("Resize SVGS "+this+ width+" "+height +" <-- " +sourceSize.width+ " "+sourceSize.height+" "+dir[ppiRange]+" " +ppi)
    }

}
