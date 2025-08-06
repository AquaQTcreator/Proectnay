import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Item {
    id:authorizacia
    height: mainWindow.height
    width:  mainWindow.width
    Rectangle {
        id:fon
        anchors.fill: parent
        color: Qt.rgba(248/255,232/255,233/255,1)
        Rectangle {
            x:mainWindow.width/15.8
            y:mainWindow.height/3.63
            height: parent.height/2.231
            width: parent.width/1.141
            radius: 20
            color: "white"
            border.width: 1
            border.color: "black"
        }
        Label {
            id:labelReturn
            x:mainWindow.width/4.19
            y:mainWindow.height/3.27
            text: "С возращением!"
            font.pixelSize: mainWindow.width/90.2 + mainWindow.height/90.2 + 10
            font.bold: true
        }
        Label {
            id:labelWelcome
            x:mainWindow.width/7.37
            y:mainWindow.height/2.77
            text: "Мы так рады видеть вас снова!"
            font.pixelSize: mainWindow.width/90.2 + mainWindow.height/90.2 + 5
        }
        Label {
            id:labelLogin
            x:mainWindow.width/6.9
            y:mainWindow.height/2.36
            text: "Логин"
            font.pixelSize: mainWindow.width/90.2 + mainWindow.height/90.2 + 2
        }
        TextField {
            id:textFieldLogin
            x:mainWindow.width/7.37
            y:mainWindow.height/2.23
            height: mainWindow.height/25.7
            width: mainWindow.width/1.37
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(148/255,201/255,169/255,1)
                radius: 10
            }
        }
        Label {
            id:labelPassword
            x:mainWindow.width/7.37
            y:mainWindow.height/1.98
            text: "Пароль"
            font.pixelSize: mainWindow.width/90.2 + mainWindow.height/90.2 + 2
        }
        TextField {
            id:textFieldPassword
            x:mainWindow.width/7.37
            y:mainWindow.height/1.89
            height:  mainWindow.height/25.7
            width:  mainWindow.width/1.37
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(148/255,201/255,169/255,1)
                radius: 10
            }
        }
        RoundButton {//Вход
            x:mainWindow.width/7.37
            y:mainWindow.height/1.69
            height: mainWindow.height/21.04
            width:  mainWindow.width/1.37
            id:buttonInput
            radius: 10
            onClicked: {
                authorizaciaClass.getDataAutorizacia(textFieldLogin.text,textFieldPassword.text);
            }
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(201/255,55/255,86/255,1);
                radius: 10
                Text {
                    anchors.centerIn: parent
                    id: txtButInput
                    text: qsTr("Вход")
                    color: "white"
                }
            }
        }
        Label {
            id:labelNeedSignUp
            x:mainWindow.width/8.91
            y:mainWindow.height/1.48
            font.pixelSize: mainWindow.width/90.2 + mainWindow.height/90.2
            text: "Нужна учетная запись?"
        }
        Label {
            id:labelSignUp
            anchors.top: labelNeedSignUp.top
            anchors.left: labelNeedSignUp.right
            anchors.leftMargin: mainWindow.width/42.8
            text:"Зарегестрироваться"
            font.pixelSize: mainWindow.width/90.2 + mainWindow.height/90.2
            color: Qt.rgba(201/255,55/255,86/255,1);
            MouseArea {
                id:mouseAreaSignUp
                anchors.fill: parent
                onClicked: //testPhoto.visible = true
                    //myModelClass.sendImage()
                    stackPage.push(registraciaQml)
            }
        }
    }
}

