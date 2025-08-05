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
        color: Qt.rgba(189/255,114/255,216/255,1)
        Label {
            x:15
            y:43
            font.pixelSize: 30
            font.bold: true
            color: "white"
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
            color: "white"
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
            color: "white"
            text: "Ингридиенту"
        }
        TextField {
            id:textFieldSeach
            x:15
            y:189
            width: 301
            height: 48
            background: Rectangle {
                anchors.fill: parent
                color: "white"
                border.color: "black"
                border.width: 2
            }
        }
        Button {
            anchors.top: textFieldSeach.top
            anchors.left: textFieldSeach.right
            anchors.leftMargin: 25
            width: 70
            height: 48
            onClicked: {
                console.log(checkName.checked,checkIngridient.checked)
                if(checkName.checked === checkIngridient.checked) {
                    lblStatusSeach.text = "Выберите один параметр"
                }
                else {
                    if (checkName.checked) parametr = "Name"
                else parametr = "Ingridient"
                    myModel.seachName(textFieldSeach.text,parametr);
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
