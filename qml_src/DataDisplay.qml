import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle {
    property int textEditMargin :15
    color: "#f5f5f4"
    radius: 3
    border.color: "#62686a"
    border.width: 1

    property int fontPixel :width/40
    property string fontFamliy :"Arial"
    Flickable {
          id: flick

          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.right: parent.right

          anchors.topMargin: textEditMargin
          anchors.bottomMargin:textEditMargin
          anchors.leftMargin:textEditMargin
          anchors.rightMargin:textEditMargin

          ScrollView {
                 anchors.fill: parent

                 TextArea {
                     activeFocusOnPress : true
                     font.pixelSize: fontPixel
                     font.family: fontFamliy
                     id: textEdit
                     width: parent.width
                     wrapMode: TextEdit.Wrap
                     selectByMouse:true

                 }

                 ScrollBar.vertical: ScrollBar {
                     anchors.top: parent.top
                     anchors.bottom: parent.bottom
                     anchors.right: parent.right
                     anchors.rightMargin:-textEditMargin/2
                     policy: ScrollBar.AlwaysOn
                 }
             }
      }

     Connections{
         target:MyDataProcess
         onDataDisplayChanged:{
             textEdit.append(MyDataProcess.displayData)
         }
     }
     Connections{
           target:MySerialManager
           onOpenSerialportFial:{
               textEdit.append("Warining : Open serial port failed,the serial port is occupied!")
           }
       }
}


