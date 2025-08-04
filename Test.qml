import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Image {
        id: name
        source: ""
    }

    Button{
    onClicked: console.log("Hello")
anchors.centerIn: parent
    }
}
