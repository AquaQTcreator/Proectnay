import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Window 2.12
Window {
    height: mainWindow.height
    width: mainWindow.width
    Button {
        id:but
        x:0
        y:50
        onClicked: myModel.setImageToDB()
    }
    Button {
        anchors.left: but.right
        onClicked: myModel.loadFromDatabase()
    }

    ListView {
        anchors.top: but.bottom
        width: 400
        height: 600
        model: myModel

        delegate: Column {
            spacing: 8

            Text {
                text: name
                font.bold: true
            }

            Image {
                source: imageRole
                width: 400
                height: 300
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                height: 1
                color: "#ccc"
                width: parent.width
            }
        }
    }
}
