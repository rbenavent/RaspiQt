import QtQuick 2.10
import QtQuick.Controls 2.4
import QtQuick.Window 2.11

//import QmlUtils 1.0
//import '../Singleton'

Text{
    property bool ajustarTextoaAncho:false

    objectName: "customText"
    font.family: "Titillium Web"
    color: "black"


    font.pixelSize: Window.height/22//apaisado? Window.height/22 : Window.width/22 //35/768*
    //esta opcion ajusta el texto al ancho del objeto si el font.pixelsize es mayor que ese ancho, ya que
    //este valor hace de maximo. el font.pixelSize tendria que ser un poco mayor para que vaya el HorizontalFit
    fontSizeMode: ajustarTextoaAncho?Text.HorizontalFit : Text.FixedSize
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter

    minimumPixelSize: 10
}
