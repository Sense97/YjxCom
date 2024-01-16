import QtQuick 2.0
import QtQuick.Controls 2.5


Rectangle{

    property int labelBtnSpacing: 15
    property int labelWidth: width/4*1
    property int labelHeight: (height-(7*labelBtnSpacing))/6/2
    property int btnWidth: width/4*2
    property int btnHeight: (height-(7*labelBtnSpacing))/6

    property int fontPixel :width/13
    property string fontFamliy :"Arial"

    width: labelWidth + btnWidth+labelBtnSpacing*3
    height: btnHeight*6 + labelBtnSpacing*8
    color: "#d5d7dd"
    radius: 3
    border.color: "#3e444e"
    border.width: 1
    Column{
         id:comConfigureLayout;
         anchors.top: parent.top
         anchors.left: parent.left
         anchors.topMargin: labelBtnSpacing
         anchors.leftMargin: labelBtnSpacing
         spacing:labelBtnSpacing;
         Row{
             id:comRowLayout;
             spacing:labelBtnSpacing;
             Label{
                 id:comLabel;
                 width:labelWidth;
                 height:labelHeight
                 anchors.verticalCenter: parent.verticalCenter;
                 text:                   qsTr("Com")
                 font.pixelSize: fontPixel
                 font.family: fontFamliy
                 wrapMode:               Text.WordWrap
                 horizontalAlignment:    Text.AlignHCenter
             }
             ComboBox{
                 objectName: "comCombox1";
                 id:comCombox;
                 width:btnWidth
                 height: btnHeight;
                 anchors.verticalCenter: parent.verticalCenter;
                 //model:MySerialPort.portName;
                 font.pixelSize: fontPixel-3
                 font.family: fontFamliy
             }
         }
         Row{
             id:baudRowLayout;
             spacing:labelBtnSpacing;
             Label{
                 id:baudLabel;
                  width:labelWidth;
                  height:labelHeight
                  anchors.verticalCenter: parent.verticalCenter;
                 text:                   qsTr("Baud")
                 font.pixelSize: fontPixel
                 font.family: fontFamliy
                 wrapMode:               Text.WordWrap
                 horizontalAlignment:    Text.AlignHCenter
             }
             ComboBox{
                 objectName: "baudCombox";
                 font.pixelSize: fontPixel-3
                 font.family: fontFamliy
                 id:baudCombox;
                 width:btnWidth
                 height: btnHeight;
                 anchors.verticalCenter: parent.verticalCenter;
                 model: ["4800","9600","38400","57600","115200","230400","460800"];
             }
         }
         Row{
             id:stopRowLayout;
             spacing:labelBtnSpacing;
             Label{
                 id:stopLabel;
                 width:labelWidth;
                 height:labelHeight
                 anchors.verticalCenter: parent.verticalCenter;
                 text:                   qsTr("Stop")
                 font.pixelSize: fontPixel
                 font.family: fontFamliy
                 wrapMode:               Text.WordWrap
                 horizontalAlignment:    Text.AlignHCenter
             }
             ComboBox{
                 objectName: "stopCombox";
                 font.pixelSize: fontPixel-3
                 font.family: fontFamliy
                 id:stopCombox;
                 width:btnWidth
                 height: btnHeight;
                 anchors.verticalCenter: parent.verticalCenter;
                 model: ["1","1.5","2"];

             }
         }
         Row{
            id:dataRowLayout;
             spacing:labelBtnSpacing;
             Label{
                 id:dataLabel;
                  width:labelWidth;
                  height:labelHeight
                  anchors.verticalCenter: parent.verticalCenter;
                 text:                   qsTr("Data")
                 font.pixelSize: fontPixel
                 font.family: fontFamliy
                 wrapMode:               Text.WordWrap
                 horizontalAlignment:    Text.AlignHCenter
             }
             ComboBox{
                 objectName: "dataCombox";
                 font.pixelSize: fontPixel-3
                 font.family: fontFamliy
                 id:dataCombox;
                 width:btnWidth
                 height: btnHeight;
                 anchors.verticalCenter: parent.verticalCenter;
                 model: ["8","7","6","5"];
             }
         }
         Row{
             id:parityRowLayout;
             spacing:labelBtnSpacing;
             Label{
                 id:parityLabel;
                 width:labelWidth;
                 height:labelHeight
                 anchors.verticalCenter: parent.verticalCenter;
                 text:                   qsTr("Parity")
                 font.pixelSize: fontPixel
                 font.family: fontFamliy
                 wrapMode:               Text.WordWrap
                 horizontalAlignment:    Text.AlignHCenter
             }
             ComboBox{
                 objectName: "parityCombox";
                 font.pixelSize: fontPixel-3
                 font.family: fontFamliy
                 id:parityCombox;
                 width:btnWidth
                 height: btnHeight;
                 anchors.verticalCenter: parent.verticalCenter;
                 model: ["NoParity","EvenParity","OddParity","SpaceParity","MarkParity"];
             }
         }
         Row{
             id:operateRowLayout;
             spacing:labelBtnSpacing;
             Label{
                 id:operateLabel;
                 width:labelWidth;
                 height:labelHeight
                 anchors.verticalCenter: parent.verticalCenter;
                 text:                   qsTr("Operate")
                 font.pixelSize: fontPixel
                 font.family: fontFamliy
                 wrapMode:               Text.WordWrap
                 horizontalAlignment:    Text.AlignHCenter
             }
             Button{
                 objectName: "operateBtn";
                 font.pixelSize: fontPixel-3
                 font.family: fontFamliy
                 id:operateBtn;
                 width:btnWidth
                 height: btnHeight;
                 anchors.verticalCenter: parent.verticalCenter;
                 text:"Open";
                 onClicked:{
                     if(text=="Open") {
                         MySerialManager.open(comCombox.currentText,
                                                        baudCombox.currentText,
                                                        stopCombox.currentText,
                                                        dataCombox.currentText,
                                                        parityCombox.currentText);
                         text="Close";
                     }
                     else {
                        MySerialManager.close()
                        text="Open";
                     }
                 }
             }
         }
     }
    Connections{
          target:MySerialManager
          onPortNameChanged:{
              console.log(MySerialManager.portName)
              comCombox.model=MySerialManager.portName;

          }
          onOpenSerialportFial:{

          }
      }

}
