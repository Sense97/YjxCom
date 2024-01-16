import QtQuick 2.12
import QtQuick.Controls 2.5


Rectangle {

    color: "#f5f5f4"
    radius: 3
    border.color: "#62686a"
    border.width: 1
    property int textWidth : width*2/10
    property int textEditWidth : width*2.5/10
    property int textHeight : height/10
    property int textEditHeight  : height/10

    property int fontPixel :width/18
    property string fontFamliy :"Arial"
    Column{
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        spacing: 5
        Grid {
            id: grid
            rows: 2
            columns: 4
            spacing: 5

            //header
            Rectangle{
                id: headerTextRectangle
                width: textWidth
                height: textHeight
                Text {
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    id: headerText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Header:")
                }
            }
            Rectangle{
                id: headerTextEditRectangle
                width: textEditWidth
                height: textEditHeight
                color: "white"
                radius: 3
                border.color: "#62686a"
                border.width: 1
                TextEdit {
                    id: headerTextEdit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "7F"
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    onTextChanged: {
                        MyDataFiliter.filiterStrHeaderChange(text);
                    }
                }
            }

            //end
            Rectangle{
                id: endTextRectangle
                width: textWidth
                height: textHeight
                Text {
                    id: endText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("End:")
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                }
            }
            Rectangle{
                id: endTextEditRectangle
                width: textEditWidth
                height: textEditHeight
                color: "white"
                radius: 3
                border.color: "#62686a"
                border.width: 1
                TextEdit {
                    id: endTextEdit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "F7"
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    onTextChanged: {
                        MyDataFiliter.filiterStrEndChange(text);
                    }
                }
            }

            //length
            Rectangle{
                id: lengthTextRectangle
                width: textWidth
                height: textHeight
                Text {
                    id: lengthText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Length:")
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                }
            }
            Rectangle{
                id: lengthTextEditRectangle
                width: textEditWidth
                height: textEditHeight
                color: "white"
                radius: 3
                border.color: "#62686a"
                border.width: 1
                TextEdit {
                    id: lengthTextEdit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: ">10"
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    onTextChanged: {
                        MyDataFiliter.filiterStrLengthChange(text);
                    }
                }
            }

            //contain
            Rectangle{
                id: containTextRectangle
                width: textWidth
                height: textHeight
                Text {
                    id: containText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Contain:")
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                }
            }
            Rectangle{
                id: containTextEditRectangle
                width: textEditWidth
                height: textEditHeight
                color: "white"
                radius: 3
                border.color: "#62686a"
                border.width: 1
                TextEdit {
                    id: containTextEdit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "0107"
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    onTextChanged: {
                        MyDataFiliter.filiterStrContainChange(text);
                    }
                }
            }
        }
        Grid {
            id: grid1
            rows: 4
            columns: 2
            spacing: 5
            //filiter name
            Rectangle{
                id:qbyteTextRectangle
                width: textWidth*2
                height: textHeight
                Text {
                    id: qbyteText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Char*")
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                }
            }
            Rectangle{
                id:midTextRectangle
                width: textWidth*2
                height: textHeight
                Text {
                    id: midText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Mid")
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                }
            }
            Rectangle{
                id: qbyteTextEditRectangle
                width: textWidth*2
                height: textHeight
                color: "white"
                radius: 3
                border.color: "#62686a"
                border.width: 1
                TextEdit {
                    id: qbyteTextEdit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "0107"
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    onTextChanged: {
                        MyDataFiliter.filiterStrIndexChange(text)
                    }
                }
            }
            Rectangle{
                id: midTextEditRectangle
                width: textWidth*2
                height: textHeight
                color: "white"
                radius: 3
                border.color: "#62686a"
                border.width: 1
                TextEdit {
                    id: midTextEdit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "4,4"
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    onTextChanged: {
                        MyDataFiliter.filiterStrMidChange(text)
                    }
                }
            }
            Rectangle{
                id:typeTextRectangle
                width: textWidth*2
                height: textHeight
                Text {
                    id: typeText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Type")
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                }
            }
            Rectangle{
                id:colorTextRectangle
                width: textWidth*2
                height: textHeight
                Text {
                    id: colorText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Color")
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                }
            }


            Rectangle{
                id: typeTextEditRectangle
                width: textWidth*2
                height: textHeight
                color: "white"
                radius: 3
                border.color: "#62686a"
                border.width: 1
                ComboBox{
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    objectName: "typeCombox";
                    id:typeCombox;
                    anchors.fill: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    model: ["hex","int","uint","float"];
                    onCurrentIndexChanged: {
                        MyDataFiliter.filiterStrTypeChange(textAt(currentIndex));
                    }
                }
            }
            Rectangle{
                id: colorTextEditRectangle
                width: textWidth*2
                height: textHeight
                color: "white"
                radius: 3
                border.color: "#62686a"
                border.width: 1
                ComboBox{
                    font.pixelSize: fontPixel
                    font.family: fontFamliy
                    objectName: "colorCombox";
                    id:colorCombox;
                    anchors.fill: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    model: ["red","green","yellow","blue"];
                    onCurrentIndexChanged: {
                        MyDataFiliter.filiterStrColorChange(textAt(currentIndex));
                    }
                }
            }
        }


    }
}


