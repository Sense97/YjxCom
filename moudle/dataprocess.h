#ifndef DATAPROCESS_H
#define DATAPROCESS_H

#include <QObject>
#include <QTimer>
#include "moudle/datafiliter.h"

class DataProcess : public QObject
{
    Q_OBJECT
public:
    explicit DataProcess(QObject *parent = nullptr);

    Q_PROPERTY(QString displayData  READ displayData NOTIFY dataDisplayChanged)
    QString displayData()const{
            return myDisplayData;
    }

    Q_INVOKABLE void msgSend(QString msg);
    Q_INVOKABLE void autoSend(bool openOrClose);
    Q_INVOKABLE void qmlAutoSendMsgChange(QString msg){
        qmlAutoSendMsg=msg;
    }
    Q_INVOKABLE void qmlAutoSendIntervalChange(QString ms);
    Q_INVOKABLE void msgSendMode(QString mode);
    Q_INVOKABLE void msgRecMode(QString mode);
    Q_INVOKABLE void timeShow(bool status);

    void received(QByteArray buff);

    void setDataFiliter (DataFiliter* mydataFiliter){
        dataFiliter=mydataFiliter;
    }


signals:
    void dataDisplayChanged(QString);
    void readySend(QByteArray);



private:
    bool serialPortStatus;

    DataFiliter * dataFiliter;
    bool msgRecModeHex;
    bool msgSendModeHex;
    bool timeShowStatus;
    QString myDisplayData;

    QString qmlAutoSendMsg;
    int qmlAutoSendInterval;
    QTimer *autoSendTimer;




private slots:
    void autoSendTimeOut();
public slots:
    void msgDisplay(QString frontStr,QByteArray qbyteBuff,QString qstrBuff);
    void serialPortStatusChange(bool status){
        serialPortStatus=status;
    }
};

#endif // DATAPROCESS_H
