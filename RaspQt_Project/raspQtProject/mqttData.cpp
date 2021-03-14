#include "mqttData.h"
#include <mqttclient.h>
#include <QMutex>
#include <QElapsedTimer>
#include <QJsonDocument>

MqttData::MqttData(QObject *parent) : QObject(parent){

    //recargar configuracion por orden del cloud
    connect(&_mqttClient, &MqttClient::msgReceived, this, &MqttData::onMQTTparserResp);

}

/**
 * @brief Business::onMQTTparserResp
 * @param msg
 */
void MqttData::onMQTTparserResp(const QString& msg) {
    QJsonDocument d = QJsonDocument::fromJson(msg.toUtf8());
    if (d.isObject()) {
        QString action;
        action = d.object().value("action").toString();
        QString code;
        code = d.object().value("code").toString();

        if (action == "update_data") {
            qInfo() << "MQTT: UPDATE DATA RECEIVED" << msg;
            //processApiTerminal();
        } else if (action == "restart_app") {
            qInfo() << "IOT ACTION RECEIVED" << msg;
            //singleapplication::forceExit(10);
        } else if (action == "restart_system") {
            qInfo() << "MQTT: ACTION RECEIVED" << msg;
            //singleapplication::forceExit(11);
        } else if (action == "shutdown_system") {
            qInfo() << "MQTT: ACTION RECEIVED" << msg;
            //singleapplication::forceExit(12);
        } else {
            qInfo() << "MQTT: ACTION RECEIVED" << msg;
           // emit messageMQTTAPP(msg);
        }
    }
}


/*void Utils::infiniteLoop (){
    while(true){};
}

void Utils::temporalBlockMainLoop(unsigned int miliseconds){
    QElapsedTimer etimer;
    etimer.start();
    while(true){
        if(etimer.elapsed()>miliseconds)return;
    };
}

void Utils::mutexDoubleLock(){
    QMutex mutex;
    mutex.lock();
    mutex.lock();//double lock
}*/
