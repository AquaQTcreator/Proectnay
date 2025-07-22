import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import Authorizacia 1.0
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: "lightBlue"

    Authorizacia {
        id:authorizacia1
    }

    TextField {
        id:textEditLogin
        height: 50
        width: 100
        anchors.centerIn: parent
    }

    Button {
        id:butSend
        height: textEditLogin.height
        width: textEditLogin.height
        anchors.left: textEditLogin.right
        anchors.top: textEditLogin.top
        anchors.leftMargin: 10
        onClicked: authorizacia1.getDataAutorizacia(textEditLogin.text,textEditLogin.text);
    }

    Label {
        id:headerLabelTable
        anchors.top: textEditLogin.bottom
        anchors.left: textEditLogin.left
        anchors.topMargin: 10
        color: "green"
        text:"Данные пользователей обнаружены"
    }

    Rectangle {
        anchors.top: textEditLogin.bottom
        anchors.topMargin: 50
        height: 300
        width: 500
        color: "white"
        TableView {
            anchors.fill: parent
            columnSpacing: 1
            rowSpacing: 1
            clip: true

            model: authorizacia1.myModel

            delegate: Rectangle {
                implicitWidth: 200
                implicitHeight: 50
                //color: "green"
                Text {
                    anchors.centerIn: parent
                    text: display
                }
            }
        }

    }
}
