#ifndef MQTT_H
#define MQTT_H

#include <QObject>

/**
    @brief The IoOnboard class
    Maneja las entradas y salidas de la placa.
    ENTRADAS: pinEntradas[12], pinMoneEle[6], pinFiltec[4], pinPulsadores[9] = 31
    SALIDAS:  pinSalidas[12], pinLuminosos[3], pinControlMoneEle[1], pinCCTalk[1], pinMDB[1], pinColtec[4], pinLedsTec[9] = 31
*/

class Mqtt : public QObject {
    Q_OBJECT

public:
    static Mqtt &instance() {
        static Mqtt INSTANCE;
        return  INSTANCE;
    }

    //Q_INVOKABLE virtual void outChange(unsigned out, bool state);


    explicit Mqtt(QObject* parent = nullptr);





};

#endif // IO_H
