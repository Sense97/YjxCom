import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle {

    property int fontPixel :width/13
    property string fontFamliy :"Arial"

    property int switchSpacing
    property int switchHeight:height/6-switchSpacing*2

    FiliterConfig{
        id: filiterConfig
        anchors.fill:parent
        visible: false

        Row {
            id: onfirmAndCancelBtn
            spacing: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5

            Button {
                font.pixelSize: fontPixel
                font.family: fontFamliy
                width: parent.width/2
                id: configConfirm
                text: qsTr("Confirm")
                onClicked: {
                    filiterConfig.visible = false
                    recAndSendConfig.visible = true

                }
            }
            Button {
                font.pixelSize: fontPixel
                font.family: fontFamliy
                width: parent.width/2
                id: configCancel
                text: qsTr("Cancel")
                onClicked: {
                    filiterConfig.visible = false
                    recAndSendConfig.visible = true
                }
            }
        }


    }
    Rectangle {
        id: recAndSendConfig
        anchors.fill: parent
        color: "#f5f5f4"
        radius: 3
        border.color: "#62686a"
        border.width: 1

        Column {
        id: switchGroup
        spacing: 5
        anchors.fill: parent
        visible: true
        Switch {
            height: switchHeight
            font.pixelSize: fontPixel
            font.family: fontFamliy
            id: switchRecHex
            anchors.left: parent.left
            text: qsTr("Rec Hex")
            checked: true
            onToggled: {
               if (switchRecHex.checked) {
                    MyDataProcess.msgRecMode("hex");
               }
               else{
                    MyDataProcess.msgRecMode("ascall");
               }
            }
        }
        Switch {
            height: switchHeight
            font.pixelSize: fontPixel
            font.family: fontFamliy
            id: switchRecSend
            anchors.left: parent.left
            text: qsTr("Send Hex")
            checked: true
            onToggled: {
               if (switchRecSend.checked) {
                    MyDataProcess.msgSendMode("hex");
               }
               else{
                    MyDataProcess.msgSendMode("ascall");
               }
            }
        }
        Switch {
            height: switchHeight
            font.pixelSize: fontPixel
            font.family: fontFamliy
            id: switchTimeShow
            anchors.left: parent.left
            text: qsTr("Time Show")
            checked: true
            onToggled: {
               if (switchTimeShow.checked) {
                    MyDataProcess.timeShow(true);
               }
               else{
                    MyDataProcess.timeShow(false);
               }
            }
        }
        Switch {
            height: switchHeight
            font.pixelSize: fontPixel
            font.family: fontFamliy
            id: switchAutoSend
            anchors.left: parent.left
            text: qsTr("Auto(ms)")
            checked: false
            onToggled: {
               if (switchAutoSend.checked) {
                   MyDataProcess.autoSend(true);
               }
               else{
                   MyDataProcess.autoSend(false);
               }
            }
        }

        Switch {
            height: switchHeight
            font.pixelSize: fontPixel
            font.family: fontFamliy
            id: switchDataFiliter
            anchors.left: parent.left
            text: qsTr("Filiter")
            checked: false
            onToggled: {
               if (switchDataFiliter.checked) {
                   MyDataFiliter.open();
               }
               else{
                   MyDataFiliter.close();
               }
            }
        }

    }
        RoundButton {
            height: switchHeight/1.2
            width: switchHeight
            font.pixelSize: fontPixel
            font.family: fontFamliy
            anchors.right: parent.right
            anchors.rightMargin: 10
            id: filiterConfigBtN
            y: switchDataFiliter.y
            text: "Set"

            contentItem: Image {
                        source: "qrc:/image/image/settings.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
            }
            onClicked: {
                filiterConfig.visible = true
                recAndSendConfig.visible = false
            }
        }
        Rectangle{
            id: rectangle1
            anchors.right: parent.right
            anchors.rightMargin: 10
            y: switchAutoSend.y
            width: parent.width/4
            height: switchAutoSend.height
            color: "white"
            radius: 3
            border.color: "#62686a"
            border.width: 1
            TextEdit {
                font.pixelSize: fontPixel
                font.family: fontFamliy
                id: textAutoSend
                text: qsTr("1000")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                onTextChanged: {
                    MyDataProcess.qmlAutoSendIntervalChange(text)
    //                if(switchAutoSend.checked)switchAutoSend.toggle()
    //                MyDataProcess.autoSend(false)
                }
             }
        }
    }
}




