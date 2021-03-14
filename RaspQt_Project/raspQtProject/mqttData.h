#ifndef MQTTDATA_H
#define MQTTDATA_H

#include <QObject>
#include <mqttclient.h>
#include <QJsonArray>
#include <QJsonObject>


class  MqttData: public QObject
{
    Q_OBJECT
public:
    explicit MqttData(QObject *parent = nullptr);
    //C++ main loop lock tests
    //Q_INVOKABLE void infiniteLoop ();
    //Q_INVOKABLE void temporalBlockMainLoop(unsigned int miliseconds);
    //Q_INVOKABLE void mutexDoubleLock();

private:
    MqttClient _mqttClient;

private slots:
    void onMQTTparserResp(const QString& msg);
};

#endif // UTILS_H
