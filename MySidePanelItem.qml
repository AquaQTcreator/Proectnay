import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
Item {
    id:sidePanelItem
    height: 926
    width: 269
    Rectangle {
        x:-254
        y:0
        id:mainRect
        anchors.fill: parent
        color: Qt.rgba(248/255,232/255,233/255,1)
        Label {
            x:18
            y:13
            text: "Категории"
            color: Qt.rgba(46/255,46/255,46/255,1)
            font.pixelSize: 30
        }

        Column {
            x:18
            y:74
            height: 499
            width: 202
            spacing: 20
            Image {
                width: 197
                height: 55
                source: "qrc:/assets/image/Categories/Гарниры.png"
            }
            Image {
                width: 197
                height: 55
                source: "qrc:/assets/image/Categories/Десерты.png"
            }
            Image {
                width: 197
                height: 55
                source: "qrc:/assets/image/Categories/Завтраки.png"
            }
            Image {
                width: 197
                height: 55
                source: "qrc:/assets/image/Categories/Напитки@2x.png"
            }
            Image {
                width: 197
                height: 55
                source: "qrc:/assets/image/Categories/Салаты.png"
            }
            Image {
                width: 197
                height: 55
                source: "qrc:/assets/image/Categories/Супы.png"
            }
            Image {
                width: 197
                height: 55
                source: "qrc:/assets/image/Categories/Фастфуд.png"
            }
        }
    }
}
