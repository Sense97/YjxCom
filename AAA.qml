import QtQuick 2.0
import QtQuick.Window 2.12



Rectangle {
        width: 100; height: 100
        color: "lightblue"

        Text {
            id: txt
            text: "另一个窗口"
            font.pixelSize: 20
            anchors.centerIn: parent
        }
}

