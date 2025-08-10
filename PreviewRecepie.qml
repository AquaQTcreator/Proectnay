import QtQuick 2.0
import QtQuick.Controls 2.12
Item {
    width: 428
    height: 926
    property string titleImage: ""
    property string titleText: "Описание отсутствует"
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(248/255,232/255,232/255,1)

        Image {
            x:0
            y:46
            width: parent.width
            height: 218
            id: titleImg
            source: titleImage
        }
        Text {
            id: name
            x:10
            y:287
            width:409
            height: 305
            text: titleText
            color: Qt.rgba(46/255,46/255,46/255,1)
            wrapMode: Text.WordWrap
            font {
                bold: true
                pixelSize: 17
                styleName: "Inter"
            }
        }

        RoundButton {
            id:butReady
            x:108
            y:631
            width: 184
            height: 184
            onClicked: {
                console.log("click")
                stackPage.push(preview)
            }
            background: Rectangle {
                anchors.fill: parent
                color: Qt.rgba(201/255,55/255,86/255,1);
                radius: 92
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Ингредиенты")
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
