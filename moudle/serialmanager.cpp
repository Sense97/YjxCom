#include "serialmanager.h"
#include <QDebug>


SerialManager::SerialManager(QObject *parent) : QObject(parent)
{
    myTimer=new QTimer();
    connect(myTimer, SIGNAL(timeout()), this, SLOT(handleTimeout()));
    myTimer->start(1000);

    mySerialPort=new QSerialPort();

}
void SerialManager::close(void)
{
    emit serialPortStatusChange(false);
    mySerialPort->close();
    qDebug()<<"serial port close success";
}

void SerialManager::open(QString PortName,QString BaudRate,QString Stopbits,QString Databits,QString Parity)
{
    QString _portName=PortName;
    int _baudrate=BaudRate.toInt();
    float _stopBits=Stopbits.toFloat();
    int _dataBits=Databits.toInt();
    QString _parity=Parity;

    qDebug()<<"portName:"<<_portName
           <<"baudName:"<<_baudrate
          <<"stopName:"<<_stopBits
         <<"dataName:"<<_dataBits
        <<"parityName:"<<_parity;

    mySerialPort->setPortName(_portName);
    mySerialPort->setBaudRate(_baudrate);

    if(_stopBits==1.0f) mySerialPort->setStopBits(QSerialPort::OneStop);
    else if(_stopBits==1.5f) mySerialPort->setStopBits(QSerialPort::OneAndHalfStop);
    else if(_stopBits==2.0f) mySerialPort->setStopBits(QSerialPort::TwoStop);


    if(_dataBits==5) mySerialPort->setDataBits(QSerialPort::Data5);
    else if(_dataBits==6) mySerialPort->setDataBits(QSerialPort::Data6);
    else if(_dataBits==7) mySerialPort->setDataBits(QSerialPort::Data7);
    else if(_dataBits==8) mySerialPort->setDataBits(QSerialPort::Data8);


    if(_parity=="NoParity")mySerialPort->setParity(QSerialPort::NoParity);
    else if(_parity=="EvenParity")mySerialPort->setParity(QSerialPort::EvenParity);
    else if(_parity=="OddParity")mySerialPort->setParity(QSerialPort::OddParity);
    else if(_parity=="SpaceParity")mySerialPort->setParity(QSerialPort::SpaceParity);
    else if(_parity=="MarkParity")mySerialPort->setParity(QSerialPort::MarkParity);

    if(mySerialPort->open(QIODevice::ReadWrite))
    {
        qDebug()<<"serial port open success";
        connect(mySerialPort,&QSerialPort::readyRead,this,&SerialManager::received);
        emit serialPortStatusChange(true);
    }
    else
    {
        qDebug()<<"serial port open fail";
        emit serialPortStatusChange(false);
        emit openSerialportFial();
    }
}

void SerialManager::received(void)
{
    QByteArray buff = mySerialPort->readAll();
    if(buff!="")
    {
        emit readyRead(buff);
    }
}
void SerialManager::send(QByteArray buff)
{
    if(mySerialPort->isOpen())mySerialPort->write(buff);
}

QList<QSerialPortInfo> SerialManager::availablePorts(void){

    QList<QSerialPortInfo> list;
    QStringList tempPortname;
    foreach(QSerialPortInfo portInfo, QSerialPortInfo::availablePorts()) {
        if (!isSystemPort(&portInfo)) {
            list << *((QSerialPortInfo*)&portInfo);
//            qDebug() << "portName    :" << portInfo.portName();    //调试时可以看的串口信息
//            qDebug() << "Description :" << portInfo.description();
//            qDebug() << "Manufacturer:" << portInfo.manufacturer();
            tempPortname.append(portInfo.portName());
        }
    }
    if(myPortName!=tempPortname){
        myPortName=tempPortname;
        emit portNameChanged(myPortName);      //通知前端comNameCombox下拉菜单更新
    }

    return list;
}
bool SerialManager::isSystemPort(QSerialPortInfo* port){
    // Known operating system peripherals that are NEVER a peripheral
    // that we should connect to.
    // XXX Add Linux (LTE modems, etc) and Windows as needed
    // MAC OS
    if (port->systemLocation().contains("tty.MALS")
        || port->systemLocation().contains("tty.SOC")
        || port->systemLocation().contains("tty.Bluetooth-Incoming-Port")
        // We open these by their cu.usbserial and cu.usbmodem handles
        // already. We don't want to open them twice and conflict
        // with ourselves.
        || port->systemLocation().contains("tty.usbserial")
        || port->systemLocation().contains("tty.usbmodem")) {
        return true;
    }
    return false;
}
void SerialManager::handleTimeout(){
    availablePorts();
}



