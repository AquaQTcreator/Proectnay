import QtQuick 2.0
import QtQuick.Controls 2.12
Item {
    width: 428
    height: 926
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(248/255,232/255,232/255,1)
        Label {
            x:82
            y:33
            text: "Ингрeдиенты"
            color: Qt.rgba(46/255,46/255,46/255,1)
            font {
                bold: true
                pixelSize: 30
                styleName: "Inter"
            }
        }

        ListView {
            x:9
            y:101
            height: 501
            width: 419

            model:myListModel
            delegate: Rectangle {
                height: 25
                width: 419
                color: "transparent"
                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    id: name
                    text: ingredient + " - " + value + " " + unit + "."
                    color: Qt.rgba(46/255,46/255,46/255,1)
                    font {
                        bold: true
                        pixelSize: 20
                        styleName: "Inter"
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
                    text: qsTr("Приступить")
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
                onClicked: stackPage.pop()
            }
        }
        NavigatePanel {
            anchors.bottom: parent.bottom
        }
    }

}
