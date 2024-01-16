#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

#include "moudle/serialmanager.h"
#include "moudle/dataprocess.h"
#include "moudle/datafiliter.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/image/image/cat.jpg"));
    QQmlApplicationEngine engine;

    SerialManager *serialmanager=new SerialManager();
    DataProcess *dataprocess=new DataProcess();
    DataFiliter *datafiliter=new DataFiliter();
    dataprocess->setDataFiliter(datafiliter);
    engine.rootContext()->setContextProperty("MySerialManager",serialmanager);
    engine.rootContext()->setContextProperty("MyDataProcess",dataprocess);
    engine.rootContext()->setContextProperty("MyDataFiliter",datafiliter);

    QObject::connect(serialmanager, &SerialManager::serialPortStatusChange, dataprocess, &DataProcess::serialPortStatusChange);
    QObject::connect(serialmanager, &SerialManager::readyRead, dataprocess, &DataProcess::received);
    QObject::connect(dataprocess, &DataProcess::readySend, serialmanager, &SerialManager::send);
    QObject::connect(datafiliter, &DataFiliter::msgDisplay,dataprocess, &DataProcess::msgDisplay);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
