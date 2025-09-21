import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
Item {
    width: 428
    height: 926
    property string mainLabel: "Напишите название и вес ингредиентов:"
    property string nameRecepie: ""
    property var suggestions: [] // список совпадений (приходит из C++)
    signal clearList(string text)
    onClearList:  {
       inputField.text = text
       suggestions = []
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(248/255,232/255,233/255,1)
    }
    Text {
        x:19
        y:114
        width: 383
        height: 71
        text: mainLabel
        wrapMode: Text.Wrap
        font {
            bold: true
            pixelSize: 30
            styleName: "Inter"
        }
    }

        TextField {
            id: inputField
            x:19
            y:197
            width: 238
            height: 61
            background: Rectangle {
                anchors.fill: parent
                radius: 10
            }
            onTextChanged: {
                if (text.length >= 2) {
                    suggestions = addIngredientModel.searchIngredients(text)
                } else {
                    suggestions = []
                }
            }
        }

        ListView {
             id: suggestionList
             anchors.top: inputField.bottom
             anchors.left: inputField.left
             width: inputField.width
             height: contentHeight
             model: suggestions
             visible: suggestions.length > 0

             delegate: Rectangle {
                 id: delegateRect
                 height: 25
                 width: parent.width
                 property bool highlighted: false
                 color: highlighted ? "#dcdcdc" : "white"

                 MouseArea {
                     anchors.fill: parent
                     onClicked: {
                         if (!delegateRect.highlighted) {
                             // Первый клик — подсветка
                             delegateRect.highlighted = true
                         } else {
                             // Второй клик — выбор
                             clearList(name.text)
                             delegateRect.highlighted = false
                         }
                     }
                 }

                 Text {
                     id:name
                     anchors.verticalCenter: parent.verticalCenter
                     anchors.left: parent.left
                     text: modelData
                     color: highlighted ? "#000000" : Qt.rgba(46/255,46/255,46/255,1)
                     font.bold: true
                     font.pixelSize: 20
                     font.family: "Inter"
                 }
             }
         }
    TextField {
        id:txtValue
        x:273
        y:197
        width: 78
        height: 61
        background: Rectangle {
            anchors.fill: parent
            radius: 10
        }
    }
    Button {
        x:357
        y:204
        width: 61
        height: 48
        onClicked: {
            myListModel.addIngredient(nameRecepie,inputField.text,txtValue.text)
        }
        background: Image {
            source: "qrc:/assets/image/Send.png"
        }
    }

    ListView {
        x:24
        y:304
        width:349
        height: 280
        model:myListModel
        spacing: 6
        delegate: Rectangle {
            height: 25
            width: 400
            color: "transparent"
            Rectangle {
                anchors.left: parent.left
                height:  35
                width: 350
                color: "transparent"
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    Text {
                        color: "transparent"
                        id: textIngr
                        text: ingredient
                    }
                }
            Text {
                anchors.left: parent.left
                anchors.top: parent.top
                id: ingrList
                text: ingredient + " - " + value + " " + unit + "."
                color: Qt.rgba(46/255,46/255,46/255,1)
                font {
                    bold: true
                    pixelSize: 20
                    styleName: "Inter"
                }
            }
        }
            Image {
                anchors.right: parent.right
                height: 30
                width:43
                source: "qrc:/assets/image/Trash_2.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        myListModel.deleteIngredient(nameRecepie,textIngr.text)
                    }
                }
            }
    }
}
    RoundButton {
        id:butReady
        x:108
        y:631
        width: 184
        height: 184
        background: Rectangle {
            anchors.fill: parent
            color: Qt.rgba(201/255,55/255,86/255,1);
            radius: 92
            Text {
                anchors.centerIn: parent
                text: qsTr("Далее")
                font {
                    bold: true
                    pixelSize: 20
                    styleName: "Inter"
                }
            }
        }
    }
    Image {
        id:butBack
        width: 70
        height: 70
        x:9
        y:748
        source: "qrc:/assets/image/ButBack.png"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                stackPage.pop()
            }
        }
    }
}


