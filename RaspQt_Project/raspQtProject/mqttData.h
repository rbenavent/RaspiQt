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

    static MqttData &instance() {
        static MqttData INSTANCE;
        return  INSTANCE;
    }


    explicit MqttData(QObject* parent = nullptr);

    //explicit MqttData(QObject *parent = nullptr);

    //explicit MqttData(QObject* parent = nullptr);
    //virtual ~MqttData();


private:
    MqttClient _mqttClient;

public slots:
    void onMQTTparserResp(const QString& msg);
};

#endif // UTILS_H
