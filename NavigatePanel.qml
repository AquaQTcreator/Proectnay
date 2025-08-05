import QtQuick 2.0
import QtQml 2.12
Item {
    id:root
    width: 428
    height: 90
    signal showProfil()
    signal seachName()
    Rectangle {
        anchors.bottom: navigatePanel.top
        height: 2
        width: parent.width
        color: "white"
    }

    Rectangle {
        id:navigatePanel
        width: 428
        height: 90
        color: "black"

        Image {
            x:16
            y:12
            height: 70
            width:70
            id: homeButton
            source: "qrc:/assets/image/home_2.png"
        }
        Image {
            id: seachButton
            x:117
            y:14
            height: 62
            width:62
            source: "qrc:/assets/image/Search.png"
            MouseArea {
                anchors.fill: parent
                onClicked: root.seachName()
            }
        }
        Image {
            id:chatPanel
            x:241
            y:14
            height: 70
            width:65
            source: "qrc:/assets/image/Message_write.png"
        }
        Image {
            id: userButton
            x:343
            y:25
            height: 50
            width:50
            source: "qrc:/assets/image/user_1.png"
            MouseArea {
                anchors.fill: parent
                onClicked: { root.showProfil()
                }
            }
        }
    }
}
