#include "mqttclient.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QMutex>
#include <QSslConfiguration>

#include <QQmlComponent>
#include <QQmlEngine>

//static const QString local_cert = "./ssl/device_local_cert.crt";
//static const QString azure_cert = ":/ssl/azure.crt"; // Certificado en recurso

MqttClient::MqttClient(QObject* parent) : QObject(parent) {
    //Q_INIT_RESOURCE(SSL_CERTS);
    emitReady(false);

    //#ifdef USEQML
        qmlRegisterSingletonType<MqttClient>("mqttclient.mqttclient", 1, 0, "MqttClient", [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject* {
            Q_UNUSED(engine)
            Q_UNUSED(scriptEngine)
            return &MqttClient::instance();
        });

    //#endif


}

MqttClient::~MqttClient() {
    if (client != nullptr)
        client->deleteLater();
}

void MqttClient::emitReady(bool bready) {
    m_ready = bready;
    emit ready(bready);
}

/**
    @brief MqttClient::generic_login
    Si está conectando o ya está conectado y parámetros son los mismos no reconecta.
    @param id
    @param host
    @param user
    @param password
    @param port
    @param keepalive
    @param ssl_file

void MqttClient::generic_login(const QString& id, const QString& host, const QString& user, const QString& password, int port, int keepalive, const QString& ssl_file) {
    if (_conectando || id.isEmpty() || host.isEmpty() || port <= 0)
        return;

    if (m_connected && host == m_host && id == m_id && m_port == port &&
        m_user == user && m_pass == password && m_keepalive == keepalive)
        return;

    _conectando = true;

    Q_UNUSED(ssl_file) //UBUNTU TIENE TODOS LOS CERTIFICADOS
    m_id        = id;
    m_host      = host;
    m_port      = port;
    m_user      = user;
    m_pass      = password;
    m_keepalive = keepalive;
    qDebug() << "MqttClient: m_host " << m_host;
    qDebug() << "MqttClient: m_id " << m_id;
#ifndef QT_NO_DEBUG
    qDebug() << "MqttClient: m_user " << m_user;
    qDebug() << "MqttClient: m_pass " << m_pass;
#endif
    qDebug() << "MqttClient: m_port " << m_port;
    qDebug() << "MqttClient: m_keepalive " << m_keepalive;

    QSslConfiguration sslConf = QSslConfiguration::defaultConfiguration();
    sslConf.setProtocol(QSsl::TlsV1_2);
    sslConf.setPeerVerifyMode(QSslSocket::VerifyNone);

    if (client != nullptr)
        client->deleteLater();

    client = new QMQTT::Client(m_host, static_cast<quint16>(m_port), sslConf, false, this); //no ignore selfsigned

    client->setClientId(m_id);
    connect(client, &QMQTT::Client::connected, this, &MqttClient::connected);
    connect(client, &QMQTT::Client::error, this, &MqttClient::error);
    connect(client, &QMQTT::Client::disconnected, this, &MqttClient::disconnected);
    connect(client, &QMQTT::Client::subscribed, this, &MqttClient::subscribed);
    connect(client, &QMQTT::Client::received, this, &MqttClient::received);
    connect(client, &QMQTT::Client::published, this, &MqttClient::published);
    connect(client, &QMQTT::Client::unsubscribed, this, &MqttClient::unsubscribed);

    if (host.contains("azure"))
        client->setVersion(QMQTT::V3_1_1);
    else
        client->setVersion(QMQTT::V3_1_0);
    client->setKeepAlive(static_cast<quint16>(m_keepalive));
    client->setAutoReconnect(true);
    client->setAutoReconnectInterval(500); //reconectar al segundo
    if (m_user.length() > 0)
        client->setUsername(m_user);
    if (m_pass.length() > 0)
        client->setPassword(QByteArray(m_pass.toStdString().c_str()));
    client->connectToHost();
    //publishInfo();
}*/

/**
    @brief MqttClient::startazure
    Conecta con MQTT utilizando parámetros.
    @param SASTocken
    @return

bool MqttClient::startazure(const QString& SASTocken) {

    if (SASTocken.isEmpty())
        return false;

    //port=443;//WESOCKETS
    QString value    = "([a-zA-Z0-9=%_&\\s\\-\\.]+)";
    QString regexstr = "HostName=" + value + ";DeviceId=" + value + ";SharedAccessSignature=" + value;
    QRegExp rx(regexstr);
    // QString str = "HostName=istobal.azure-devices.net;DeviceId=device2;SharedAccessSignature=SharedAccessSignature sr=istobal.azure-devices.net%2Fdevices%2Fdevice2&sig=cNjjcAnbn6ZlvrxTAwNqcrx7rf%2BsI27OGW%2FTwz2Gxsw%3D&se=1532792639";
    //  QString str = "HostName=istobal.azure-devices.net;DeviceId=device_test;SharedAccessSignature=SharedAccessSignature sr=istobal.azure-devices.net%2Fdevices%2Fdevice_test&sig=OXuvsQ5iF6Kj2vg21xB3b7WNfbh9OI6uzJXpWiXTWDA%3D&se=1532792659";

    if (rx.indexIn(SASTocken) == -1)
        return false;

    // qDebug()<<"**********************AZURE IOT MODULE**********************";
    // qDebug()<<"SASTOCKEN "<< str;

    QString host = rx.cap(1);
    QString id   = rx.cap(2);
    //QString user = host + "/" + id;
    QString pass = rx.cap(3);


    return startazure(host, id, pass);
}*/

/**
 * @brief MqttClient::startazure
 * @param hostname
 * @param deviceId
 * @param shareSig
 * @return

bool MqttClient::startazure(const QString& hostname, const QString& deviceId, const QString& shareSig) {


    m_device           = deviceId;
    const QString user = hostname + "/" + deviceId;
    //QString &pass = shareSig;
    QString ssl_file = "";
    const int port   = 1883;

    //grabo el fichero de certificado de recursos a un fichero temporal ...para libmosquitto
    QFile extern_certificate(local_cert); //debe de estar en el home
    if (extern_certificate.exists()) {
        ssl_file = local_cert;
        qInfo() << "MqttClient: SET EXTERNAL CERT " << ssl_file;
    } else {
        QFile certificate;
        if (hostname.toLower().contains("azure")) {
            // qDebug()<<"IOT: SET TLS AZURE";
            certificate.setFileName(azure_cert);
        }

        if (!certificate.exists()) {
            qCritical() << "MqttClient: INEXISTENT CERT FILE :" << certificate.fileName();
            return false;
        }

        if (_tmp.open()) { //para tener el certificado en recursos
            certificate.open(QFile::ReadOnly | QFile::Text);
            QTextStream in(&certificate);
            QString myText = in.readAll();
            QTextStream out(&_tmp);
            out << myText;
        } else {
            qCritical() << "MqttClient: CAN'T CREATE TMP FILE FOR CERTFICATE " << _tmp.fileName();
            return false;
        }
        _tmp.close();
        //tls_set(tmp.fileName().toStdString().c_str());
        ssl_file = _tmp.fileName();
    }
    generic_login(deviceId, hostname, user, shareSig, port, 15, ssl_file);

    return true;
}*/

void MqttClient::init(const QString& hostname,const QString& port){
    client = new QMQTT::Client(static_cast<QHostAddress>(hostname), 1883);

    client->setClientId("clientId");
    //client->setUsername("user");
    //client->setPassword("password");
    client->connectToHost();

    //client->setClientId("m_id");
    qDebug() << "MqttClient -> client->setClientId" << " - hostname:" <<hostname  << " - port:" <<port;
    connect(client, &QMQTT::Client::connected, this, &MqttClient::connected);
    connect(client, &QMQTT::Client::error, this, &MqttClient::error);
    connect(client, &QMQTT::Client::disconnected, this, &MqttClient::disconnected);
    connect(client, &QMQTT::Client::subscribed, this, &MqttClient::subscribed);
    connect(client, &QMQTT::Client::received, this, &MqttClient::received);
    connect(client, &QMQTT::Client::published, this, &MqttClient::published);
    connect(client, &QMQTT::Client::unsubscribed, this, &MqttClient::unsubscribed);
}

void MqttClient::error(const QMQTT::ClientError error) {
    if (m_lastError != error) {
        qInfo() << "MqttClient ERROR::ClientError" << error;
    }
    m_lastError = error;
    _conectando = false;

    emit onerror(error);
}

int MqttClient::publish(const QString& payload) {
    if (client != nullptr) {
        if (m_connected) {
            qDebug() << "MqttClient::PUBLISH " << payload.toUtf8();
            QString subscriptionTag = "devices/" + m_device + "/messages/events/";

            QMQTT::Message var(uid, subscriptionTag, payload.toUtf8());
            client->publish(var);

            uid++;
            m_sended_message = payload;

            return var.id();
        }
    }
    return -1;
}

void MqttClient::close() {
    if (!m_connected) {
        emitReady(false);
        return;
    }
    client->disconnectFromHost();
    _conectando = false;
}

void MqttClient::connected() {
    client->subscribe("#", 0);
    //    _timer.start(1000);
    m_connected = true;
    qDebug() << "MqttClient:CONNECTED";
    _conectando = false;
}

void MqttClient::disconnected() {
    qInfo() << "MqttClient:DISCONNECTED";
    m_connected = false;
    _conectando = false;
    emitReady(false);
}

void MqttClient::subscribed(const QString& topic) {
    qInfo() << "MqttClient:subscribed " << topic;
    emitReady(true);

    m_lastSocketError = -1;
    m_lastError       = -1;
}

void MqttClient::unsubscribed(const QString& topic) {
    qInfo() << "MqttClient:unsubscribed " << topic;
    emitReady(false);
}

void MqttClient::received(const QMQTT::Message& message) {
    m_received_message = QString::fromUtf8(message.payload());
    emit msgReceived(m_received_message);
    qInfo() << "MqttClient:received - emit  msgReceived" << m_received_message;

    QJsonDocument d = QJsonDocument::fromJson(m_received_message.toUtf8());
    if(message.topic() == "sensoresporche/sensor/temperatura_porche/state"){
        QString Ta= message.payload();
        QString kk = Ta;
        emit sgnTemperaturaPorche(Ta);
    }

    if(message.topic() == "sensoresporche/sensor/humedadporche/state"){
        QString Ha= message.payload();
        QString kk = Ha;
    }

    if(message.topic() == "sensoresporche/sensor/temperatura_comedor/state"){
        QString Ta_comedor= message.payload();
        QString kk = Ta_comedor;
        emit msgTemperaturaComedor(Ta_comedor);
    }

    if(message.topic() == "timbrecocina/sensor/temperaturacocina/state"){
        QString Ta_cocina= message.payload();
        QString kk = Ta_cocina;
        emit msgTemperaturaCocina(Ta_cocina);
    }

    /*if (d.isObject()) {
        QString name;
        name = d.object().value("TemperaturaPorche").toString();
        QString code;
        code = d.object().value("code").toString();
    }*/

}

void MqttClient::published(const QMQTT::Message& message, quint16 msgid) {
    qInfo() << "MqttClient:publish send confirmation: \"" << msgid << "  " << QString::fromUtf8(message.payload())
            << "\"";
}
