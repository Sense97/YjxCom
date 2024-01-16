#include "dataprocess.h"
#include <QDebug>
#include <QDateTime>

DataProcess::DataProcess(QObject *parent) : QObject(parent)
{
    msgRecModeHex=true;
    msgSendModeHex=true;
    timeShowStatus=true;
    serialPortStatus=false;

    autoSendTimer= new QTimer;
    connect(autoSendTimer, SIGNAL(timeout()), this, SLOT(autoSendTimeOut()));
}

QString byteArrayToHexString(const QByteArray &byteArray) {
    QString hexString;

    for (char byte : byteArray) {
        // 将每个字节转换为两位的16进制数
        hexString.append(QString("%1").arg(static_cast<quint8>(byte), 2, 16, QLatin1Char('0')).toUpper());
    }

    int len = hexString.length();

    // 插入空格
    for (int i = 2; i < len; i += 3) {
        hexString.insert(i, ' ');
        len+=1;
    }

    return hexString;
}

void DataProcess::received(QByteArray buff)
{
    if(dataFiliter->isOpen()&&msgRecModeHex){  //打开过滤器，打开hex接受
        msgDisplay("RX",dataFiliter->qbyteFiliter(buff),"");
    }
    else if(dataFiliter->isOpen()&&!msgRecModeHex){ //打开过滤器，关闭hex接受
        msgDisplay("RX","",dataFiliter->qstrFiliter(QString::fromUtf8(buff)));
    }
    else if(!dataFiliter->isOpen()&&msgRecModeHex){ //关闭过滤器，打开hex接受
        msgDisplay("RX",buff,"");
    }
    else if(!dataFiliter->isOpen()&&!msgRecModeHex){ //关闭过滤器，关闭hex接受
        msgDisplay("RX","",QString::fromUtf8(buff));
    }
}
void DataProcess::msgSend(QString msg)
{
    if(!serialPortStatus){
        myDisplayData="Warining : Serial port is not open!";
        emit dataDisplayChanged(myDisplayData);
        return;
    }

    if(msg=="") return;
    msgDisplay("TX","",msg);


    if(msgSendModeHex)//hex to send
    {
        msg.remove(QChar(' '));
        QByteArray buff = QByteArray::fromHex(msg.toLatin1());
        emit readySend(buff);

    }
    else //ascall to send
    {
        QByteArray buff=msg.toUtf8();
        emit readySend(buff);
    }
}
void DataProcess::autoSend(bool openOrClose)
{
    if(openOrClose){
//        autoSendTimer= new QTimer;
//        connect(autoSendTimer, SIGNAL(timeout()), this, SLOT(autoSendTimeOut()));
        autoSendTimer->start(qmlAutoSendInterval);
    }
    else{
        //disconnect(autoSendTimer, SIGNAL(timeout()), this, SLOT(autoSendTimeOut()));
        autoSendTimer->stop();
        //delete autoSendTimer;
    }

}
void DataProcess::autoSendTimeOut()
{
   msgSend(qmlAutoSendMsg);
}
void DataProcess::msgDisplay(QString frontStr,QByteArray qbyteBuff,QString qstrBuff)
{
    if(qbyteBuff!=""){
        if(msgRecModeHex)//hex to rec
        {

            if(timeShowStatus){
                QDateTime currentDateTime = QDateTime::currentDateTime();
                myDisplayData=frontStr+":["+currentDateTime.toString("hh:mm:ss:zzz")+"] "+byteArrayToHexString(qbyteBuff);
            }
            else{
                myDisplayData=frontStr+" -> "+byteArrayToHexString(qbyteBuff);
            }
            emit dataDisplayChanged(myDisplayData);

        }
        else //ascall to rec
        {
            QString tempStrBuff = QString::fromUtf8(qbyteBuff);
            if(timeShowStatus){
                QDateTime currentDateTime = QDateTime::currentDateTime();
                myDisplayData=frontStr+":["+currentDateTime.toString("hh:mm:ss:zzz")+"] "+tempStrBuff;
                emit dataDisplayChanged(myDisplayData);
            }
            else{
                myDisplayData="Rec -> "+tempStrBuff;
                emit dataDisplayChanged(myDisplayData);
            }
        }

    }
    else if(qstrBuff!=""){
        QDateTime currentDateTime = QDateTime::currentDateTime();
        if(timeShowStatus){
            myDisplayData=frontStr+":["+currentDateTime.toString("hh:mm:ss:zzz")+"] "+qstrBuff;
            emit dataDisplayChanged(myDisplayData);
        }
        else{
            myDisplayData=frontStr+" -> "+qstrBuff;
            emit dataDisplayChanged(myDisplayData);
        }

    }
}

void DataProcess::msgSendMode(QString mode){
    if(mode=="hex")msgSendModeHex=true;
    else msgSendModeHex=false;
}
void DataProcess::msgRecMode(QString mode){
    if(mode=="hex")msgRecModeHex=true;
    else msgRecModeHex=false;
}
void DataProcess::timeShow(bool status){
    timeShowStatus=status;
}
void DataProcess::qmlAutoSendIntervalChange(QString ms){
    qmlAutoSendInterval=ms.toInt();
    if(autoSendTimer->isActive())
    autoSendTimer->setInterval(qmlAutoSendInterval);

}





