import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.2

import "./qml_src/" //导入qml_src中所有qml

ApplicationWindow  {
    visible: true
    width: 800
    height: 600
    title: qsTr("Yjx Com")


    SerialManager{
        id: serialManager
        width:parent.width/4
        height:parent.height/2
        anchors.top: parent.top
        anchors.left: parent.left
    }

    Configure{
        id: configure
        width:parent.width/4
        height:parent.height/2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }
    DataDisplay{
        id: dataDisplay
        width:parent.width/4*3
        height:parent.height/4*3
        anchors.top: parent.top
        anchors.right: parent.right
    }

    DataSend{
        id: dataSend
        width:parent.width/4*3
        height:parent.height/4*1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }

}
