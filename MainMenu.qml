import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
Item {
    height: mainWindow.height
    width: mainWindow.width

    property string sendName: ""
    property string sendLastName: ""
    property string sendLogin: ""
    property string sendPassword: ""

    Rectangle {
        id:mainRect
        anchors.fill: parent
        color: Qt.rgba(189/255,114/255,216/255,1)
        Button {
            id:but
            x:0
            y:50
            onClicked: myModel.setImageToDB()
            enabled: false
        }
        Button {
            anchors.left: but.right
            onClicked: myModel.loadFromDatabase()
            enabled: false
        }

        Rectangle {
            width: parent.width + 4
            height: 66
            border.color: "white"
            border.width: 2
            anchors.top: parent.top
            anchors.topMargin: -2
            anchors.left: parent.left
            anchors.leftMargin: -2
            color: "black"
            Image {
                id: categoriiButton
                x:26
                y:7
                source: "qrc:/assets/image/Hamburger_LG.png"
            }
        }

        Image {
            id: labelMain
            x:8
            y:72
            width: 232
            height: 51
            source: "qrc:/assets/image/labelMain.png"
        }

        ListView {
            id:listElementTool
            orientation: ListView.Horizontal
            width: parent.width
            clip: true
            height: 114
            spacing: 15
            x:0
            y:132
            model:["qrc:/assets/image/addRecepie.png"
                ,"qrc:/assets/image/famous.png"
                ,"qrc:/assets/image/myRecepie.png"]
            delegate: Image {
                source: modelData
                width: 130
                height: 90
                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log(index)
                }
            }
        }

        Image {
            x:9
            y:242
            width: 230
            height: 64
            id: labelWhatNeed
            source: "qrc:/assets/image/labelWhatNeed.png"
        }

        ListView {
            id:listElementpox
            orientation: ListView.Horizontal
            width: parent.width
            clip: true
            height: 122
            spacing: 15
            x:0
            y:310
            model:["qrc:/assets/image/dinner.png"
                ,"qrc:/assets/image/supper.png"
                ,"qrc:/assets/image/breakfast.png"]
            delegate: Image {
                source: modelData
                width: 130
                height: 90
            }
        }

        Image {
            x:9
            y:428
            width: 220
            height: 64
            id: labelRecepie
            source: "qrc:/assets/image/labelRecepie.png"
        }

        GridView {
            id:mainListView
            anchors.left: parent.left
            anchors.leftMargin: 40
            y:490
            width: 428
            height: 345
            cellWidth: 180;
            cellHeight: 160

            model: myModel
            clip: true
            //         anchors.leftMargin: 20

            delegate: Rectangle {
                height: 150
                width: 140
                color:"black"
                radius: 8
                clip: true
                Rectangle {
                    id:imgdel
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 2
                    height: 130  // 130 - 4 (по 2px с каждой стороны)
                    radius:6.5
                    clip: true
                    color: "black"
                    Image {
                        id:delegateImage
                        anchors.fill: imgdel
                        source: imageRole
                        fillMode: Image.PreserveAspectCrop
                        visible: false
                    }
                }
                OpacityMask {
                    anchors.fill: imgdel
                    source: delegateImage
                    maskSource: imgdel
                }
                Rectangle {
                    anchors.top: imgdel.bottom
                    anchors.topMargin: -10
                    height: 28
                    width: parent.width
                    color: "white"
                    border.color: "black"
                    border.width: 2
                    Text {
                        anchors.centerIn: parent
                        id:textItem
                        text: name
                        font.bold: true
                        width: parent.width
                        elide: Text.ElideRight
                        font.pointSize: 6
                    }
                }
            }
        }
        NavigatePanel {
            anchors.bottom: parent.bottom
            id:myBottomPanel
            onShowProfil: {
                mainRect.enabled = false
                ////////
                pageLoader.source = "Profil.qml"
                pageLoader.item.nameQml = sendName
                pageLoader.item.lastNameQml = sendLastName
                pageLoader.item.loginQml = sendLogin
                pageLoader.item.passwordQml = sendPassword
                        myAnimationStart.start()
            }
        }

        NumberAnimation { //showAnimation
            id:myAnimationStart
            targets: [pageLoader]
            properties: "x"
            to: 0
            duration: 200
        }

        NumberAnimation { //closeAnimation
            id:myAnimationClose
            target: pageLoader
            property: "x"
            to:-428
            duration: 200
            onStopped:  {
                mainRect.enabled = true
                pageLoader.source = ""
            }
        }
    }

    Loader {
        id:pageLoader
        x:-428
        y:0
        source: ""
    }

    Connections {
        target: pageLoader.item
        onCloseThisItem: {
            myAnimationClose.start()
        }
    }
}
