import QtQuick 2.0
import QtQuick.Controls 2.12
Item {
    height: mainWindow.height
    width: mainWindow.width
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(214/255,94/255,122/255,1)
        Rectangle {
            anchors.centerIn: parent
            color: "white"
            width: 369
            height: 551
            border.color: "black"
            border.width: 1
            radius: 20
        }

        Label {
            id:labelReturn
            x:61
            y:214
            text: "Создать учетную запись"
            font.pixelSize: 25
            font.bold: true
        }

        Label {
            id:labelName
            x:61
            y:256
            text: "Имя"
            font.pixelSize: 17
        }

        TextField {
            id:textFieldName
            x:61
            y:282
            height: 32
            width: 308
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(166/255,166/255,166/255,1)
                radius: 20
            }
        }

        Label {
            id:labelLastName
            x:61
            y:335
            text: "Фамилия"
            font.pixelSize: 17
        }

        TextField {
            id:textFieldLastName
            x:61
            y:361
            height: 32
            width: 308
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(166/255,166/255,166/255,1)
                radius: 20
            }
        }

        Label {
            id:labelLogin
            x:61
            y:412
            text: "Логин"
            font.pixelSize: 17
        }

        TextField {
            id:textFieldLogin
            x:61
            y:438
            height: 32
            width: 308
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(166/255,166/255,166/255,1)
                radius: 20
            }
        }

        Label {
            id:labelPassword
            x:61
            y:489
            text: "Придумайте пароль"
            font.pixelSize: 17
        }

        TextField {
            id:textFieldPassword
            x:61
            y:515
            height: 32
            width: 308
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(166/255,166/255,166/255,1)
                radius: 20
            }
        }

        Label {
            id:labelReturnPassword
            x:61
            y:567
            text: "Повторите пароль"
            font.pixelSize: 17
        }

        TextField {
            id:textFieldreturnPassword
            x:61
            y:590
            height: 32
            width: 308
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(166/255,166/255,166/255,1)
                radius: 20
            }
        }

        RoundButton {
            id:buttonSignUp
            x:61
            y:653
            height: 32
            width: 312
            text: "Зарегестрироваться"
            onClicked: if (textFieldPassword.text == textFieldreturnPassword.text) {
                           signUp.getDataForSignUp(textFieldName.text,textFieldLastName.text,textFieldLogin.text,textFieldPassword.text)
                       }
                       else console.log ("passwords not same");
        }
        Label {
            id:labelStatus
            x:30
            y:628
            text: statusQml
            font.pixelSize: 14
            color: "Red"
        }

        Label {
            id:labelSignUp
            font.pixelSize: 17
            text: "Уже зарегестрированы?"
            color: "blue"
            x:61
            y:694
            MouseArea {
                id:mouseAreaAlreadySignUp
                anchors.fill: parent
                onClicked: {
                    stackPage.pop();
                    textFieldName.clear();textFieldLastName.clear();textFieldLogin.clear();textFieldPassword.clear();textFieldreturnPassword.clear()
                }
            }
        }
    }
}
