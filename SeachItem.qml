import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
Item {
    width: 428
    height: 254
    signal poisk()
    property  string parametr: ""
    Rectangle { ////////////////////////POISCK
        id:seachWindow
        anchors.centerIn: parent
        width: parent.width
        height: 301
        color: Qt.rgba(248/255,232/255,233/255,1)
        Label {
            x:15
            y:43
            font.pixelSize: 30
            font.bold: true
            color: Qt.rgba(46/255,46/255,46/255,1)
            text: "Искать по..."
        }
        CheckBox {
            id:checkName
            x:15
            y:85
        }
        Label {
            anchors.top:checkName.top
            anchors.left: checkName.right
            anchors.leftMargin: 6
            font.pixelSize: 30
            font.bold: true
            color: Qt.rgba(46/255,46/255,46/255,1)
            text: "Названию"
        }
        CheckBox {
            id:checkIngridient
            x:15
            y:127
        }
        Label {
            anchors.top:checkIngridient.top
            anchors.left: checkIngridient.right
            anchors.leftMargin: 6
            font.pixelSize: 30
            font.bold: true
            color: Qt.rgba(46/255,46/255,46/255,1)
            text: "Ингридиенту"
        }
        TextField {
            id:textFieldSeach
            x:15
            y:189
            width: 301
            height: 48
            background: Rectangle {
                radius: 20
                anchors.fill: parent
                color: Qt.rgba(148/255,201/255,169/255,1)
                border.color: "white"
                border.width: 2
            }
        }
        RoundButton {
            anchors.top: textFieldSeach.top
            anchors.left: textFieldSeach.right
            anchors.leftMargin: 25
            width: 70
            height: 48
            background: Rectangle {
                anchors.fill: parent
                radius: 20
                color: Qt.rgba(201/255,55/255,86/255,1);
            }

            onClicked: {
                console.log(checkName.checked,checkIngridient.checked)
                if(checkName.checked === checkIngridient.checked) {
                    lblStatusSeach.text = "Выберите один параметр"
                }
                else {
                    if (checkName.checked) parametr = "Name"
                else parametr = "Ingridient"
                    myMainModel.seachName(textFieldSeach.text,parametr);
                    poisk();
                }
            }
        }
        Label {
            id:lblStatusSeach
            x:33
            y:270
            text: ""
            font.pixelSize: 15
            color: "red"
        }
    }
}
