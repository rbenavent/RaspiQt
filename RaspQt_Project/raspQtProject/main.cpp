#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtDebug>

#include <QOpenGLContext>
#include <QOpenGLFunctions>
#include <QQuickWindow>

#include "io.h"
#include "iocicthread.h"
#include "mqttclient.h"
#include "utils.h"


//MAIN LOOP WDT.
//#include "mainLoopWdt.h"

int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    //argument test
    auto argList = QCoreApplication::arguments();
    qDebug() << "APP ARGUMENTS:" << argList;
    argList.pop_front();
    QString env_wdt_test = qgetenv("WDT_TEST");
    qDebug() << "ENV WDT_TEST=" << env_wdt_test;
    qputenv("WDT_TEST", "test ok"); //set magic word to WDT_TEST

    //Io* Io = new Io();
    Io::instance();
    IoCicThread::instance();
//    iocicthread::instance();

    //Connect mqtt using TCP:
    //MqttClient::instance();//bad code - connect this one
    //MqttClient _mqttClient;//bad code - use the second

    MqttClient &_mqttClient = MqttClient::instance(); //si el instance devuelve puntero: MqttClient &_mqttClient = *MqttClient::instance();
    _mqttClient.init("192.168.0.22","1883");
    //_mqttClient.subscribed("sensoresporche/sensor/temperatura_comedor/state");
    //_mqttClient.subscribed("sensoresporche/sensor/temperatura_porche/state");
    //_mqttClient.subscribed("sensoresporche/sensor/temperatura_comedor/state");
    //_mqttClient.subscribed("timbrecocina/sensor/temperaturacocina/state");

    //_mqttClient.startazure("","","");

    QQmlApplicationEngine engine;

    //WDT for QT mainLoop.
    //@param restartApp  true: Blocking the  main event loop restarts the application  , false:  Blocking the  main event loop kills the application
    //@param warningTimeut_ms  timeout (ms) since locking the main event loop, once fulfilled, a warning message is displayed
    //@param restartTimeut_ms  timeout (ms) since locking the main event loop, once fulfilled, the application is killed or restarted
    //@param appRestart_ms timeout (ms) to restart application. Maybe some software may need time after shutdown before restarting
    //@param parent  QObject parent
    //    mainLoopWdt wdt(true, 2000, 5000, 0, &app); //Declare WWDT Instance

    Utils util;                                                    //utility for C++ infinite loop
    engine.rootContext()->setContextProperty("Utils", &util);      //test: C++ main loop block
                                                                   //    engine.rootContext()->setContextProperty("WDT", &wdt);         //test: force restart
    engine.rootContext()->setContextProperty("ENV", env_wdt_test); //test: keep environment variables between reboots
    engine.rootContext()->setContextProperty("ARGLIST", argList);  //test: keep process arguments
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
            qCritical() << "******************* ERROR LOADING MAIN !!!!!!!!!!! **************** ";
            return -1;
        }

        // Crea ventana root en engine
        QQuickWindow* window = dynamic_cast<QQuickWindow*>(engine.rootObjects().at(0));

        if (window) {
            //DATOS OPENGL
            QObject::connect(window, &QQuickWindow::sceneGraphInitialized,
                             [window, &engine]() -> void {
                                 auto context     = window->openglContext();
                                 auto functions   = context->functions();
                                 QString vendor   = reinterpret_cast<const char*>(functions->glGetString(GL_VENDOR));
                                 QString renderer = reinterpret_cast<const char*>(functions->glGetString(GL_RENDERER));
                                 QString version  = reinterpret_cast<const char*>(functions->glGetString(GL_VERSION));
                                 QString shading  = reinterpret_cast<const char*>(functions->glGetString(GL_SHADING_LANGUAGE_VERSION));
                                 qInfo() << ("OPENGL: Vendor: " + vendor + ", Renderer: " + renderer + ", Version: " + version + ", Shader:   " + shading);
                             });
        }

        if (window) {
            if (QGuiApplication::platformName() == QLatin1String("qnx") ||
                QGuiApplication::platformName() == QLatin1String("eglfs") ||
                QSysInfo::currentCpuArchitecture().toLower().contains("arm")) {
                window->showFullScreen();
            } else {
                window->showMaximized();
            }
        }

    //wdt.startWdt(); //start WDT
    return app.exec();
}
