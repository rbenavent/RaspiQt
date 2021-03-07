#include <QDebug>

#include <io.h>
#include <iocicthread.h>

#include <QQmlComponent>
#include <QQmlEngine>


/**
    @brief Io::Io
    @param parent
*/
Io::Io(QObject* parent) : QObject(parent) {

    //#ifdef USEQML
        qmlRegisterSingletonType<Io>("io.io", 1, 0, "Io", [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject* {
            Q_UNUSED(engine)
            Q_UNUSED(scriptEngine)
            return &Io::instance();
        });
    //#endif
        auto& ioCicThread = IoCicThread::instance();

        connect(&ioCicThread, &IoCicThread::sgnReadIn, this, &Io::onInChange, Qt::QueuedConnection);
        connect(&ioCicThread, &IoCicThread::sgnReadOut, this, &Io::onOutChange);//, Qt::QueuedConnection);
        connect(&ioCicThread, &QThread::finished, this, &Io::onThreadFinished);

        ioCicThread.start(QThread::HighestPriority);

        //reemitir la señal en el main loop
        connect(this, &Io::onInChange, this, &Io::sgnInputs, Qt::QueuedConnection);
}


/**
    @brief ::::
    @param value
*/
void Io::onInChange(int value) {
    emit sgnInputs(value);
    qDebug() << "eviamos las entradas" << value ;
}


void Io::onOutChange(int value) {

}



/**
    @brief IoCic::outChange
    @param out
    @param state
*/
void Io::outChange(unsigned out, bool state) {
    //qDebug() << "CAMBIA SALIDA" << out << "A ESTADO" << state; //llena de mensajes al tener activo el PMR / Tecl.Matricial

    auto& ioCicThread = IoCicThread::instance();
    ioCicThread.setOut(static_cast<unsigned char>(out), state);
}


/**
    @brief IoCic::getOut
    @return
*/
int Io::getOut() {
    //return _outprev;
    return 0;
}

/**
    @brief IoCic::getIn
    @return
*/
int Io::getValue() {
    //return _inprev;
    return 0;
}

/**
    @brief IoCic::isError
    @return
*/
bool Io::isError() {
    //return _error;
    return false;
}

/**
    @brief IoCic::onThreadFinished
*/
void Io::onThreadFinished() {
    //onError(true);
}
