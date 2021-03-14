#include <QDebug>

#include <mqtt.h>
//#include <QtMqtt/QtMqtt>

#include <QQmlComponent>
#include <QQmlEngine>


/**
    @brief Mqtt::Mqtt
    @param parent
*/
Mqtt::Mqtt(QObject* parent) : QObject(parent) {

    //#ifdef USEQML
        qmlRegisterSingletonType<Mqtt>("io.mqtt", 1, 0, "Mqtt", [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject* {
            Q_UNUSED(engine)
            Q_UNUSED(scriptEngine)
            return &Mqtt::instance();
        });
    //#endif

 //       m_client = new QMqttClient(this);
   //     m_client->setHostname(ui->lineEditHost->text());
     //   m_client->setPort(ui->spinBoxPort->value());
}






