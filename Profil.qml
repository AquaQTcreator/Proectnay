import QtQuick 2.0
import QtQuick.Controls 2.12
import AuthorizaciaClass 1.0
Item {
    height: 926
    width: 428
    id:profilItem
    signal closeThisItem()
    property string nameQml: ""
    property string lastNameQml: ""
    property string loginQml: ""
    property string passwordQml: ""

    Rectangle{
        anchors.fill: parent
        color:Qt.rgba(125/255,254/255,177/255,1)
        Image {
            x:77
            y:75
            width: 254
            height:214
            source: "qrc:/assets/image/user_black.png"
        }

        Rectangle {
            x:12
            y:318
            width: 404
            height: 320
            border.color: "black"
            border.width: 2
            radius: 47
            color: Qt.rgba(241/255,205/255,205/255,1)
            Label {
                x:30
                y:40
                id: labelNickname
                text: "Name"
                font.bold: true
                font.pixelSize: 30
            }
            Label {////////////////Name
                x:211
                y:30
                id: textName
                text: nameQml
                font.bold: true
                font.pixelSize: 30
            }
            Label {
                x:30
                y:95
                id: labelLastname
                text: "Family"
                font.bold: true
                font.pixelSize: 30
            }
            Label {////////////////LastName
                x:211
                y:101
                id: textLastname
                text: lastNameQml
                font.bold: true
                font.pixelSize: 30
            }
            Label {
                x:30
                y:150
                id: labelLogin
                text: "Login"
                font.bold: true
                font.pixelSize: 30
            }
            Label { ////////////////Login
                x:211
                y:150
                id: textLogin
                text: loginQml
                font.bold: true
                font.pixelSize: 30
            }
            Label {
                x:30
                y:215
                id: labelPassword
                text: "Password"
                font.bold: true
                font.pixelSize: 30
            }
            Label { ////////////////Password
                x:211
                y:215
                id: textPassword
                text: passwordQml
                font.bold: true
                font.pixelSize: 30
            }
        }
        NavigatePanel {
            anchors.bottom: parent.bottom
            onShowProfil: closeThisItem()
        }
    }
}
