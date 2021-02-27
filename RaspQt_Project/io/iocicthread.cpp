#include <QDebug>
#include <iocicthread.h>

#include <QDir>
#include <QFile>
#include <QMutex>
#include <unistd.h>

static QMutex out_mutex;

#ifdef _RASPI_
#define DIRGPIO "./gpio/"
#elif __arm__
#define DIRGPIO "/sys/class/gpio/"
#else
#define DIRGPIO "/sys/class/gpio/"
#endif

IoCicThread::IoCicThread(QObject* parent) : QThread(parent) {

    initIOEntradas();
    initIOSalidas();
}

/**
    @brief IoCicThread::initIO
*/
void IoCicThread::initIO(unsigned char pin, IN_OUT in_out, bool value) {
#ifdef _RASPI_
    QString dirgpio = QString(DIRGPIO "gpio%1").arg(pin);
    if (!QDir(dirgpio).exists())
        QDir().mkpath(dirgpio);
#elif __arm__
    QFile fexp(DIRGPIO "export");
    if (!fexp.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qCritical() << "Failed to export gpio!" << pin;
        return;
    }
    QTextStream sexp(&fexp);
    sexp << pin << endl;
    fexp.close();
#else
    QString dirgpio = QString(DIRGPIO "gpio%1").arg(pin);
    if (!QDir(dirgpio).exists())
        QDir().mkpath(dirgpio);
#endif

    QString dir = QString(DIRGPIO "gpio%1/direction").arg(pin);
    QFile fdir(dir);

    if (!fdir.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qCritical() << "Failed to direction gpio!" << dir;
        return;
    }
    QTextStream sdir(&fdir);
    QString d = (in_out == IN) ? "in" : "out";
    sdir << d << endl;
    fdir.close();

    if (in_out == OUT) {
        QString val = QString(DIRGPIO "gpio%1/value").arg(pin);
        QFile fval(val);

        if (!fval.open(QIODevice::WriteOnly | QIODevice::Text)) {
            qCritical() << "Failed to value gpio!";
            return;
        }
        QTextStream sval(&fval);
        QString v = value ? "1" : "0";
        sval << v << endl;
        fval.close();
    }
}

void IoCicThread::initIOEntradas(void) {
    for (int i = 0; i < MAXENTRADAS; i++)
        initIO(_entradas.pinEntradas[i]);
}

void IoCicThread::initIOSalidas(void) {

    for (int i = 0; i < MAXSALIDAS; i++)
        initIO(_salidas.pinSalidas[i], OUT, true);
}

/**
    @brief IoCicThread::getIn
    @param pin
    @return
*/
bool IoCicThread::getIn(unsigned char pin) {
    if (pin >= sizeof(CIC_ENTRADAS))
        return false;

    const unsigned char* const aux = (const unsigned char* const)(&_entradas);

    QString val = QString(DIRGPIO "gpio%1/value").arg(*(aux + pin));
    QFile fval(val);

    if (!fval.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qCritical() << "Failed to value gpio IN!" << val;
        return false;
    }
    QTextStream sval(&fval);
    return sval.read(1) != "0";
}

/**
    @brief IoCic::getOut
    @param pin
    @return
*/
bool IoCicThread::getOut(unsigned char pin) {
    if (pin >= sizeof(CIC_SALIDAS))
        return false;

    const unsigned char* const aux = (const unsigned char* const)(&_salidas);

    QString val = QString(DIRGPIO "gpio%1/value").arg(*(aux + pin));
    QFile fval(val);

    if (!fval.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qCritical() << "Failed to value gpio get OUT!" << val;
        return false;
    }
    QTextStream sval(&fval);
    return sval.read(1) != "0";
}

/**
    @brief IoCicThread::setOut
    @param pin
    @param value
    @return
*/
bool IoCicThread::setOut(unsigned char pin, bool value) {
    if (pin >= sizeof(CIC_SALIDAS))
        return false;

    QMutexLocker lock(&out_mutex);
    const unsigned char* const aux = (const unsigned char* const)(&_salidas);

    QString val = QString(DIRGPIO "gpio%1/value").arg(*(aux + pin));
    QFile fval(val);

    if (!fval.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qCritical() << "Failed to value gpio set OUT!";
        return false;
    }
    QTextStream sval(&fval);
    QString v = value ? "1" : "0";
    sval << v << endl;
    fval.close();
    return true;
}

/**
    @brief IoCicThread::readIn
    Lee todas las entradas (generales y específicas) periódicamente y si ha cambiado genera señal sgnReadIn
*/
void IoCicThread::readIn() {
    int in = 0;

    for (unsigned char i = 0; i < sizeof(CIC_ENTRADAS); i++)
        if (getIn(i))
            in |= 1U << i;

    if (in != _prevInt) {
        _prevInt = in;
        sgnReadIn(in);
    }
}

/**
    @brief IoCicThread::readInRetardo
    Lee las entradas de los botones capacitivos periódicamente, aplica un retardo anti-rebote y si ha cambiado genera señal sgnReadIn

void IoCicThread::readInRetardo() {
    int in         = 0;
    _algunaPulsada = false;
    for (unsigned char i = 0; i < MAXBOTONLED; i++) {
        if (getInCapacitivos(i)) {
            _algunaPulsada = true;
            in |= 1U << i;
        }
    }

    if (_algunaPulsada) {
        if (in != _prevInt) {
            _prevInt    = in;
            _tDescuento = 5;
        }
        if (_tDescuento == 0)
            sgnReadIn(in);
    }
}*/

/**
    @brief IoCicThread::readOut
*/
void IoCicThread::readOut() {
    QMutexLocker lock(&out_mutex);
    int out = 0;

    for (unsigned char i = 0; i < sizeof(CIC_SALIDAS); i++) {
        if (getOut(i))
            out |= 1U << i;
    }

    if (out != _prevOut) {
        _prevOut = out;
        sgnReadOut(out);
    }
}

/**
    @brief IoCicThread::slotTimerTick
    @details tiempo antirebotes para los botones capacitivos

void IoCicThread::slotTimerTick() {
    if (_tDescuento > 0)
        _tDescuento--;
}*/

void IoCicThread::run() {

    while (true) {
        readIn();
        //readInRetardo();
        readOut();
        msleep(100);
    }
}
