import QtQuick 2.12
import QtQuick.Controls 2.5


Rectangle {
    property int fontPixel :width/40
    property string fontFamliy :"Arial"

    Rectangle{
        color: "#d5d7dd"
        radius: 3
        border.color: "#3e444e"
        border.width: 1


        anchors.fill: parent
        Flickable {
              id: flick

              anchors.top: parent.top
              anchors.bottom: parent.bottom
              anchors.left: parent.left
              anchors.right: parent.right
              property int textEditMargin :15
              anchors.topMargin: textEditMargin
              anchors.bottomMargin:textEditMargin
              anchors.leftMargin:textEditMargin
              anchors.rightMargin:textEditMargin

              ScrollView {
                     anchors.fill: parent

                     TextArea {
                         selectByMouse:true
                         font.pixelSize: fontPixel
                         font.family: fontFamliy
                         id: textSend
                         width: parent.width
                         wrapMode: TextEdit.Wrap
                         onTextChanged: {
                            MyDataProcess.qmlAutoSendMsgChange(text)
                         }
                     }
                 }
          }
    }
    RoundButton {
        id: btnSend

        visible: true
        anchors.right: parent.right
        anchors.rightMargin:15
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width/5*1
        height: parent.height/3*1
        text: "Send"
        checked: false
        checkable: false

        contentItem: Image {
                    source: "qrc:/image/image/send.png"
                    //anchors.centerIn: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectFit
        }
        onClicked: {
            MyDataProcess.msgSend(textSend.text)
            //console.log("Button Clicked!")
        }
    }

}


