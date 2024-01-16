#ifndef DATAFILITER_H
#define DATAFILITER_H

#include <QObject>

class DataFiliter : public QObject
{
    Q_OBJECT
public:
    explicit DataFiliter(QObject *parent = nullptr);

    QByteArray qbyteFiliter(QByteArray buff);
    QString    qstrFiliter(QString msg);

    bool isOpen(){
        return  isOpenStatus;
    }
    Q_INVOKABLE void open(){
        isOpenStatus=true;
    }
    Q_INVOKABLE void close(){
        isOpenStatus=false;
    }

    Q_INVOKABLE void filiterStrHeaderChange(QString str);
    Q_INVOKABLE void filiterStrEndChange(QString str);
    Q_INVOKABLE void filiterStrLengthChange(QString str);
    Q_INVOKABLE void filiterStrContainChange(QString str);

    Q_INVOKABLE void filiterStrIndexChange(QString str);
    Q_INVOKABLE void filiterStrMidChange(QString str);
    Q_INVOKABLE void filiterStrColorChange(QString str);
    Q_INVOKABLE void filiterStrTypeChange(QString str);
signals:
    void msgDisplay(QString frontStr,QByteArray qbyteBuff,QString qstrBuff);
private:
    bool isOpenStatus;

    QString filiterStrLength;
    char filiterLenghtSymbol;
    int filiterLenght;

    QString filiterStrHeader;
    QByteArray filiterByteHeader;

    QString filiterStrEnd;
    QByteArray filiterByteEnd;

    QString filiterStrContain;
    QByteArray filiterByteContain;

    /********************/

    QString filiterStrIndex;
    QByteArray filiterByteIndex;

    QString filiterStrMid;
    int filiterMidIndex;
    int filiterMidLength;

    QString filiterStrColor;
    QString filiterStrType;

public slots:
};

#endif // DATAFILITER_H
