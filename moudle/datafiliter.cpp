#include "datafiliter.h"
#include <QDebug>
#include <QDataStream>
#include <cstring>
DataFiliter::DataFiliter(QObject *parent) : QObject(parent)
{
    isOpenStatus=false;
}

template <typename T>
QString byteArrayToNumericString(const QByteArray &byteArray) {
    if (byteArray.size() < sizeof(T)) {
        qWarning() << "Byte array is too short for conversion";
        return QString();
    }

    // 使用QDataStream将QByteArray按值转换为T类型
    QDataStream stream(byteArray);
    T numericValue;
    stream >> numericValue;


    // 将T类型转换为QString进行显示
    return QString::number(static_cast<qreal>(numericValue), 'f',0);
}
QString byteArrayToFloat(const QByteArray &byteArray) {
    if (byteArray.size() < sizeof(float)) {
        qWarning() << "Byte array is too short for conversion";
        return "";
    }

    float floatValue;
        QByteArray reversedArray = byteArray;
        std::reverse(reversedArray.begin(), reversedArray.end()); // 翻转字节顺序
        std::memcpy(&floatValue, reversedArray.constData(), sizeof(float));

     qWarning() << floatValue;
    // 将T类型转换为QString进行显示
    int precision = QString::number(static_cast<qreal>(floatValue)).length();
    return QString::number(static_cast<qreal>(floatValue), 'f', precision);
}
QByteArray DataFiliter::qbyteFiliter(QByteArray buff)
{
    QByteArray result;//用于返回空指针

    /*过滤长度*/
    if(!filiterStrLength.isEmpty()){
        switch (filiterLenghtSymbol) {
            case  '=':
            if(buff.length()!=filiterLenght) {
                qDebug()<<"msg length != "<<filiterLenght;
                return result;
            }
            break;
        case  '>':
            if(buff.length()<=filiterLenght) {
                qDebug()<<"msg length <= "<<filiterLenght;
                return result;
            }
            break;
            case  '<':
            if(buff.length()>=filiterLenght) {
                qDebug()<<"msg length >= "<<filiterLenght;
                return result;
            }
            break;

            default:
            return result;
        }
    }

    /*过滤帧头*/
    if(!filiterStrHeader.isEmpty()){
        if(buff.mid(0,filiterByteHeader.length())!=filiterByteHeader) {
            qDebug()<<"msg without"<<filiterByteHeader.toHex();
            return result;
        }
    }
    /*过滤包含*/
    if(!filiterStrContain.isEmpty()){
        if(!buff.contains(filiterByteContain)) {
            qDebug()<<"msg without"<<filiterByteContain.toHex();
            return result;
        }
    }
    /*过滤帧尾*/
    if(!filiterStrEnd.isEmpty()){
        if(buff.mid(buff.size()-filiterByteEnd.length(),filiterByteEnd.length())!=filiterByteEnd) {
            qDebug()<<"msg without"<<filiterByteEnd.toHex();
            return result;
        }
    }

    /*寻找数组*/
    if(!filiterStrIndex.isEmpty()&&!filiterStrMid.isEmpty()){

        QString resultString;
        result=buff.mid((buff.indexOf(filiterByteIndex,0)+filiterMidIndex),filiterMidLength);

        if(filiterStrType=="hex"){
            emit msgDisplay("filiter hex->",result,"");
            return "";
        }
        else if(filiterStrType=="int"){

            if(result.size()==1)    resultString = byteArrayToNumericString<int8_t>(result);
            else if(result.size()==2)    resultString = byteArrayToNumericString<int16_t>(result);
            else if(result.size()==4)    resultString = byteArrayToNumericString<int32_t>(result);
            else if(result.size()==8)    resultString = byteArrayToNumericString<int64_t>(result);
            //qDebug() << "Converted QString (int): " << resultString;
            emit msgDisplay("filiter int->","",resultString);
            return "";
        }
        else if(filiterStrType=="uint"){
            if(result.size()==1)    resultString = byteArrayToNumericString<uint8_t>(result);
            else if(result.size()==2)    resultString = byteArrayToNumericString<uint16_t>(result);
            else if(result.size()==4)    resultString = byteArrayToNumericString<uint32_t>(result);
            else if(result.size()==8)    resultString = byteArrayToNumericString<uint64_t>(result);
            //qDebug() << "Converted QString (uint): " << resultString;
            emit msgDisplay("filiter uint->","",resultString);
            return "";
        }
        else if(filiterStrType=="float"){
            if(result.size()==4)    resultString = byteArrayToFloat(result);
            //qDebug() << "Converted QString (float): " << resultString <<" result.size()="<<result.size();
            emit msgDisplay("filiter float->","",resultString);
            return "";
        }
    }
    return buff;
}
QString DataFiliter::qstrFiliter(QString msg)
{
    qDebug()<<"strFiliter"<<msg;
    return msg;

}
void DataFiliter::filiterStrLengthChange(QString str){
    filiterStrLength=str;
    filiterLenghtSymbol=str.at(0).toLatin1();
    filiterLenght=str.remove(0,1).toInt();
}
void DataFiliter::filiterStrHeaderChange(QString str){
    filiterStrHeader=str;
    filiterByteHeader=QByteArray::fromHex(str.replace(" ","").toUtf8());
}
void DataFiliter::filiterStrContainChange(QString str){
    filiterStrContain=str;
    filiterByteContain=QByteArray::fromHex(str.replace(" ","").toUtf8());
}
void DataFiliter::filiterStrEndChange(QString str){
    filiterStrEnd=str;
    filiterByteEnd=QByteArray::fromHex(str.replace(" ","").toUtf8());
}
/*****/
void DataFiliter::filiterStrIndexChange(QString str){
    filiterStrIndex=str;
    filiterByteIndex=QByteArray::fromHex(str.replace(" ","").toUtf8());
    //qDebug()<<filiterStrIndex;
}

void DataFiliter::filiterStrMidChange(QString str){
    filiterStrMid=str;
    if(str.indexOf(',')==-1) qDebug()<<"Can not fine comma!";
    filiterMidIndex= str.left(str.indexOf(',')).toInt();
    filiterMidLength= str.mid(str.indexOf(',')+1).toInt();
    //qDebug()<<filiterMidIndex<<","<<filiterMidLength;

}
void DataFiliter::filiterStrColorChange(QString str){
    filiterStrColor=str;
    //qDebug()<<filiterStrColor;
}
void DataFiliter::filiterStrTypeChange(QString str){
    filiterStrType=str;
    //qDebug()<<filiterStrType;
}


