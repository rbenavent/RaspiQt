#ifndef MQTTCLIENT_H
#define MQTTCLIENT_H

#include <QQmlEngine>
#include <QTemporaryFile>
#include <qmqtt.h>

class MqttClient : public QObject {
    Q_OBJECT
public:
    /**
        @brief MqttClient
        @param parent
    */


    static MqttClient &instance() {
        static MqttClient INSTANCE;
        return  INSTANCE;
    }


    explicit MqttClient(QObject* parent = nullptr);
    virtual ~MqttClient();

    Q_INVOKABLE virtual void publish_topic(const QString& TOPIC_CONTROL,const QString& payload);

    /**
        @brief startazure : MQTT login to azure MQTT server
        @param SASTocken complete SASTocken form azure
        @return true SASTocken is OK
    */
    //bool startazure(const QString& SASTocken);

    /**
     * @brief startazure
     * @param hostname
     * @param deviceId
     * @param shareSig
     * @return
     */
    //bool startazure(const QString& hostname, const QString& deviceId, const QString& shareSig);

    /**
        @brief generic_login GENERIC MQTT LOGIN
        @param id
        @param host
        @param user
        @param password
        @param port
        @param keepalive
        @param ssl_file
    */
    //void generic_login(const QString& id, const QString& host, const QString& user, const QString& password, int port, int keepalive, const QString& ssl_file);
    void close();

    bool isReady() {
        return m_ready; // Está correctamente subscrito
    }
    bool isConnected() {
        return m_connected; //Está correctamente conectado a MQTT
    }

    void init(const QString &hostname, const QString &port);

signals:

    void msgReceived(const QString& msg);
    void sgnTemperaturaPorche(QString msg);
    void sgnTemperaturaComedor(QString msg);
    void sgnTemperaturaCocina(QString msg);

private:
    QTemporaryFile _tmp;

    QString m_id;
    QString m_host;
    QString m_user;
    QString m_pass;
    QString m_device;

    QString m_received_message;
    QString m_sended_message;

    int m_port;
    int m_keepalive       = 300;
    int m_lastError       = -1;
    int m_lastSocketError = -1;

    quint16 uid      = 0;
    bool _conectando = false;
    bool m_connected = false;
    bool m_ready     = false;

    /**
        @brief client pointer to MQTT client
    */
    QMQTT::Client* client = nullptr;

    void emitReady(bool bready);


public slots:

    void connected();
    void disconnected();
    int publish(const QString& TOPIC_CONTROL,const QString& payload);
    void subscribed(const QString& topic);
    void unsubscribed(const QString& topic);
    void received(const QMQTT::Message& message);
    void published(const QMQTT::Message& message, quint16 msgid = 0);
    void error(const QMQTT::ClientError error);

signals:
    /**
        @brief ready SIGNAL
        @param ready
    */
    void ready(bool ready);

    //signal del error
    void onerror(const QMQTT::ClientError error);
};


#endif // MQTTCLIENT_H
