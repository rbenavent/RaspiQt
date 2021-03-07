#ifndef IO_H
#define IO_H

#include <QObject>

/**
    @brief The IoOnboard class
    Maneja las entradas y salidas de la placa.
    ENTRADAS: pinEntradas[12], pinMoneEle[6], pinFiltec[4], pinPulsadores[9] = 31
    SALIDAS:  pinSalidas[12], pinLuminosos[3], pinControlMoneEle[1], pinCCTalk[1], pinMDB[1], pinColtec[4], pinLedsTec[9] = 31
*/

class Io : public QObject {
    Q_OBJECT

public:
    static Io &instance() {
        static Io INSTANCE;
        return  INSTANCE;
    }

    Q_INVOKABLE virtual void outChange(unsigned out, bool state);
    Q_INVOKABLE virtual int getOut();
    Q_INVOKABLE virtual int getValue();
    Q_INVOKABLE virtual bool isError();

    explicit Io(QObject* parent = nullptr);

signals:
    void sgnInputs(int value);

public slots:
    void onInChange(int out);
    void onOutChange(int out);

private slots:
    void onThreadFinished();

};

#endif // IO_H
