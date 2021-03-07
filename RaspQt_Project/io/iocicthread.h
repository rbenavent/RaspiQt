#ifndef IOCICTHREAD_H
#define IOCICTHREAD_H

#include <QThread>
#include <QTimer>

/*************** ENTRADAS Y SALIDAS CIC ***********************/
#define IO00 0
#define IO01 1
#define IO02 2
#define IO03 3
#define IO04 4
#define IO05 5
#define IO06 6
#define IO07 7
#define IO08 8
#define IO09 9
#define IO10 10
#define IO11 11
#define IO12 12
#define IO13 13
#define IO14 14
#define IO15 15
#define IO16 16
#define IO17 17
#define IO18 18
#define IO19 19
#define IO20 20
#define IO21 21
#define IO22 22
#define IO23 23
#define IO24 24
#define IO25 25
#define IO26 26
#define IO27 27
#define IO28 28
#define IO29 29
#define IO30 30
#define IO31 31
#define IO32 32

// ENTRADAS GENERALES
#define INP1 IO23
#define INP2 IO24
#define INP3 IO25
#define INP4 IO16

#define MAXENTRADAS 4

//SALIDAS GENERALES
#define OUT1 IO17
#define OUT2 IO27
#define OUT3 IO22
#define OUT4 IO05
#define OUT5 IO06
#define OUT6 IO26

#define MAXSALIDAS 6

// MONEDERO CCTALK
const char portCCTalk[] = "/dev/ttymxc4";

// MONEDERO MDB
const char portMDB[] = "/dev/ttymxc3";

/**
    @brief The IoCicThread class
    Hilo que lee constantemente todas las entradas y salidas

    ENTRADAS: pinEntradas[12], pinMoneEle[6], pinFiltec[4], pinPulsadores[9] = 31
    SALIDAS:  pinSalidas[12], pinLuminosos[3], pinControlMoneEle[1], pinCCTalk[1], pinMDB[1], pinColtec[4], pinLedsTec[9] = 31

*/
class IoCicThread : public QThread {
    Q_OBJECT
public:
    IoCicThread(const IoCicThread&) = delete;
    IoCicThread(IoCicThread&&)      = delete;
    IoCicThread& operator=(const IoCicThread&) = delete;
    IoCicThread& operator=(IoCicThread&&) = delete;

    static IoCicThread& instance() {
        static IoCicThread INSTANCE;
        return INSTANCE;
    }

    // Todas las entradas de la CIC
    struct ENTRADAS {
        const unsigned char pinEntradas[MAXENTRADAS] = {INP1, INP2, INP3, INP4};
    };

    // Todas las salidas de la CIC
    struct SALIDAS {
        const unsigned char pinSalidas[MAXSALIDAS] = {OUT1, OUT2, OUT3, OUT4, OUT5, OUT6};
    };

    bool setOut(unsigned char pin, bool value);
    bool getIn(unsigned char pin);

protected:
    virtual void run();

private:
    enum IN_OUT { IN,
                  OUT };

    const ENTRADAS _entradas;
    const SALIDAS _salidas;

    int _prevOut;
    int _prevInt;

    explicit IoCicThread(QObject* parent = nullptr);

    void initIO(unsigned char pin, IN_OUT in_out = IN, bool value = false);
    void initIOEntradas();
    void initIOSalidas();

    bool getOut(unsigned char pin);
    void readIn();
    void readOut();
signals:
    void sgnReadIn(int in);
    void sgnReadOut(int out);
};

#endif // IOCICTHREAD_H
