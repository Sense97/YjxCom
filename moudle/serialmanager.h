#ifndef SERIALMANAGER_H
#define SERIALMANAGER_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QTimer>

class SerialManager : public QObject
{   
    Q_OBJECT

public:
    explicit SerialManager(QObject *parent = nullptr);

    Q_PROPERTY(QStringList portName  READ portName NOTIFY portNameChanged)
    Q_PROPERTY(NOTIFY openSerialportFial)

    Q_INVOKABLE void open(QString PortName,QString BaudRate,QString Stopbits,QString Databits,QString Parity);
    Q_INVOKABLE void close(void);

    QStringList portName()const{
            return myPortName;
    }

    QList<QSerialPortInfo> availablePorts();
    static bool isSystemPort(QSerialPortInfo *port);
    void send(QByteArray buff);
private:

    QStringList myPortName;
    QTimer *myTimer;
    QSerialPort *mySerialPort;
    void received(void);


signals:
    void portNameChanged(QStringList);
    void readyRead(QByteArray);
    void openSerialportFial();
    void serialPortStatusChange(bool status);

public slots:
    void handleTimeout();  //超时处理函数

};

#endif // SERIALMANAGER_H



