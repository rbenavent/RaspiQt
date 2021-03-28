import QtQuick 2.7
import QtGraphicalEffects 1.0
//import NetworkQueue 1.0
//import istobal.cloud.business 1.0

//import "../Widgets"
//import "./weather"

Item{
    id:item
    property var root:parent
    //property string locale:TR.locale
    property color iconColor:"white"
    //localizacion
    //si queremos nombre de ciudad, habria que mirar la API de yahoo
    property string latitud: "39.05132"
    property string longitud: "-0.4251"
    property string urlWeather:"http://api.openweathermap.org/data/2.5/weather"

    implicitWidth: 253
    implicitHeight: 58
    function startMonitoring(){
        timer.stop()
        timer.restart()

    }

    /*Connections{
        target:TR
        onRetranslate:processDate() //cambio de idioma al momento de la fecha (no esperar al timer que cambia la hora)
    }*/

    Timer{
        id:timer
        interval:10000//15000
        repeat: true
        running: false
        triggeredOnStart: true
        onTriggered: {

            latitud
            if(latitud==="9999" &longitud==="9999") return;
            var url=urlWeather+"?lat="+latitud
            url+="&lon="+longitud
            url+="&mode=json"
            url+="&APPID="+ "a6a24bc53de9ed1931bd2a368f44fdee"
            url+="&lang="+ "sp"
            getUrl(url)

        }
    }
    Timer {
        interval: 500
        repeat: true
        running: true
        onTriggered:processDate()
    }



    //formar fecha y hora. tienen en cuenta el idioma actual "propiedad locale del formuario" para aplicar los locales a fecha y hora
    function processDate(){
        var ndate=new Date()
        hour.text=ndate.toLocaleTimeString(Qt.locale(), Locale.ShortFormat);
        date.text=ndate.toLocaleDateString(Qt.locale(), Locale.ShortFormat);//LongFormat);
    }

    CustomText{
        id:date
        anchors.left: img.right
        anchors.leftMargin: img.width/4
        x:0
        y:0
        font.bold: false
        font.pixelSize: parent.height/5
        height: label.font.pixelSize
        color:"black"//"#808080";//"#C0C0C0";//"black";
    }

    CustomText{
        id:label
        property double temp:0
        property string code:""
        property string enWeather:""
        visible:code.length>0

        text:(temp).toFixed(0) +"ºC"

        x:0
        y:0//parent.height
        font.bold: true
        font.pixelSize: parent.height/5
        height: font.pixelSize
        //anchors.verticalCenter: parent.verticalCenter
        color: "black"// "#808080";//"white";
    }
    CustomText{
        id:description
        x:0
        y:parent.height*0.75
        font.bold: false
        font.pixelSize: parent.height/5
        height: label.font.pixelSize
        color:"black"//"#808080";//"#C0C0C0";//"black";
    }

    //CustomTextes un Text con unas cosas por efecto, fuente etc
    CustomText{
        id:hour
        visible: false
        anchors.left: img.right
        anchors.leftMargin: 17/253*parent.width
        anchors.top: label.bottom
        font.bold: true
        font.pixelSize: parent.height/4
        height: label.font.pixelSize
        color:"black";//"white";        
    }

    //ImageSvg es un Image con unas cosas por efecto, optimizado pora SVG   
    ImageSvg{
        id:img
        width: parent.height*0.9
        height: parent.height*0.9
        //anchors.verticalCenter: parent.verticalCenter
        x:0
        y:0
        visible:true
    }
    //pasar el SVG a iconColor
    /*ColorOverlay {
        visible: img.source!="" &&img.status==Image.Ready
        anchors.fill: img
        source: img
        color: iconColor
    }*/



    function getUrl(url) {
        var  http = new XMLHttpRequest()

        http.open("GET", url, true);
        http.setRequestHeader("Accept","application/json");

        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.readyState === XMLHttpRequest.DONE) {
                if (http.status === 200) {

                    var objectjson= JSON.parse(http.responseText) //parsear JSON
                    if(!objectjson|| !objectjson.weather|| !objectjson.main) return
                    var condition=objectjson.weather[0].icon //ver JSON respuesta

                    var idYahoo=setWeatherIconOpenWeather(condition)

                    label.temp=parseFloat(objectjson.main.temp-273)
                    label.code=idYahoo //  objectjson.weather[0].description
                    //label.enWeather=objectjson.weather[0].description
                    description.text=objectjson.weather[0].description
                } else {
                    console.log("error consulta HTTP WEATHER: " + http.status+"--"+http.statusText )
                }

            }
        }
        http.send();
    }
        function setWeatherIconOpenWeather(weatherIcon) {
        switch (weatherIcon) {
        case "01d":
        case "01n":
           return setWeatherIcon('32')//  "../icons/weather-sunny.png"
        case "02d":
        case "02n":
            return setWeatherIcon('28') //"../icons/weather-sunny-very-few-clouds.png"
        case "03d":
        case "03n":
          return setWeatherIcon('34') //  "../icons/weather-few-clouds.png"
        case "04d":
        case "04n":
            return setWeatherIcon('26') // "../icons/weather-overcast.png"
        case "09d":
        case "09n":
           return setWeatherIcon('10') // "../icons/weather-showers.png"
        case "10d":
        case "10n":
            return setWeatherIcon('10') //"../icons/weather-showers.png"
        case "11d":
        case "11n":
             return setWeatherIcon('14') //"../icons/weather-thundershower.png"
        case "13d":
        case "13n":
            return setWeatherIcon('15') //"../icons/weather-snow.png"
        case "50d":
        case "50n":
             return setWeatherIcon('20') //""../icons/weather-fog.png"
        default:
            return setWeatherIcon('25')
        }

    }

    //formar el nombre de icono en funcion del código yahho
    function setWeatherIcon(condid) {
        var icon = '';
        switch(condid) {
        case '0': icon  = 'wi-tornado';
            break;
        case '1': icon = 'wi-storm-showers';
            break;
        case '2': icon = 'wi-tornado';
            break;
        case '3': icon = 'wi-thunderstorm';
            break;
        case '4': icon = 'wi-thunderstorm';
            break;
        case '5': icon = 'wi-snow';
            break;
        case '6': icon = 'wi-rain-mix';
            break;
        case '7': icon = 'wi-rain-mix';
            break;
        case '8': icon = 'wi-sprinkle';
            break;
        case '9': icon = 'wi-sprinkle';
            break;
        case '10': icon = 'wi-hail';
            break;
        case '11': icon = 'wi-showers';
            break;
        case '12': icon = 'wi-showers';
            break;
        case '13': icon = 'wi-snow';
            break;
        case '14': icon = 'wi-storm-showers';
            break;
        case '15': icon = 'wi-snow';
            break;
        case '16': icon = 'wi-snow';
            break;
        case '17': icon = 'wi-hail';
            break;
        case '18': icon = 'wi-hail';
            break;
        case '19': icon = 'wi-cloudy-gusts';
            break;
        case '20': icon = 'wi-fog';
            break;
        case '21': icon = 'wi-fog';
            break;
        case '22': icon = 'wi-fog';
            break;
        case '23': icon = 'wi-cloudy-gusts';
            break;
        case '24': icon = 'wi-cloudy-windy';
            break;
        case '25': icon = 'wi-thermometer';
            break;
        case '26': icon = 'wi-cloudy';
            break;
        case '27': icon = 'wi-night-cloudy';
            break;
        case '28': icon = 'wi-day-cloudy';
            break;
        case '29': icon = 'wi-night-cloudy';
            break;
        case '30': icon = 'wi-day-cloudy';
            break;
        case '31': icon = 'wi-night-clear';
            break;
        case '32': icon = 'wi-day-sunny';
            break;
        case '33': icon = 'wi-night-clear';
            break;
        case '34': icon = 'wi-day-sunny-overcast';
            break;
        case '35': icon = 'wi-hail';
            break;
        case '36': icon = 'wi-day-sunny';
            break;
        case '37': icon = 'wi-thunderstorm';
            break;
        case '38': icon = 'wi-thunderstorm';
            break;
        case '39': icon = 'wi-thunderstorm';
            break;
        case '40': icon = 'wi-storm-showers';
            break;
        case '41': icon = 'wi-snow';
            break;
        case '42': icon = 'wi-snow';
            break;
        case '43': icon = 'wi-snow';
            break;
        case '44': icon = 'wi-cloudy';
            break;
        case '45': icon = 'wi-lightning';
            break;
        case '46': icon = 'wi-snow';
            break;
        case '47': icon = 'wi-thunderstorm';
            break;
        case '3200': icon = 'wi-cloud';
            break;
        default: icon = 'wi-cloud';
            break;
        }

        img.source= "./weather/"+ icon+'.svg';

        return condid //devolver el numero de id equivalente a yahoo
    }
    //formar el nombre del estado en funcion del código.
    //Ya viene en la API de yahoo, pero quiero que sea traducible.
    function setWeatherText(condid) {
            var description = '';
            switch(condid) {
            case "0" : description=qsTr("tornado");break;
            case "1" : description=qsTr("tormenta tropical");break;
            case "2" : description=qsTr("huracán");break;
            case "3" : description=qsTr("tormentas severas");break;
            case "4" : description=qsTr("tormentas");break;
            case "5" : description=qsTr("lluvia y nieve");break;
            case "6" : description=qsTr("lluvia y aguanieve");break;
            case "7" : description=qsTr("nieve y aguanieve");break;
            case "8" : description=qsTr("llovizna gélida");break;
            case "9" : description=qsTr("llovizna");break;
            case "10" : description=qsTr("lluvia congelada");break;
            case "11" : description=qsTr("chubascos");break;
            case "12" : description=qsTr("chubascos");break;
            case "13" : description=qsTr("ráfagas de nieve");break;
            case "14" : description=qsTr("nieve ligera");break;
            case "15" : description=qsTr("nieve con viento");break;
            case "16" : description=qsTr("nieve");break;
            case "17" : description=qsTr("granizo");break;
            case "18" : description=qsTr("aguanieve");break;
            case "19" : description=qsTr("tormenta polvo");break;
            case "20" : description=qsTr("nieve");break;
            case "21" : description=qsTr("niebla");break;
            case "22" : description=qsTr("nublado");break;
            case "23" : description=qsTr("tempestuoso");break;
            case "24" : description=qsTr("viento");break;
            case "25" : description=qsTr("frío");break;
            case "26" : description=qsTr("nublado");break;
            case "27" : description=qsTr("nubes y claros");break;
            case "28" : description=qsTr("nubes y claros");break;
            case "29" : description=qsTr("parcialmente nublado");break;
            case "30" : description=qsTr("parcialmente nublado");break;
            case "31" : description=qsTr("despejado");break;
            case "32" : description=qsTr("soleado");break;
            case "33" : description=qsTr("templado");break;
            case "34" : description=qsTr("templado");break;
            case "35" : description=qsTr("lluvia y granizo");break;
            case "36" : description=qsTr("cálido");break;
            case "37" : description=qsTr("tormentas aisladas");break;
            case "38" : description=qsTr("tormentas dispersas");break;
            case "39" : description=qsTr("tormentas dispersas");break;
            case "40" : description=qsTr("lluvias dispersas");break;
            case "41" : description=qsTr("nieve intensa");break;
            case "42" : description=qsTr("chubascos dispersos");break;
            case "43" : description=qsTr("nieve intensa");break;
            case "44" : description=qsTr("parcialmente nublado");break;
            case "45" : description=qsTr("lluvia con truenos");break;
            case "46" : description=qsTr("chubascos de nieve");break;
            case "47" : description=qsTr("tormentas dispersas");break;
            case "3200" : description=qsTr("no disponible");break;
            default: description="";
            }
            return description
        }
}
