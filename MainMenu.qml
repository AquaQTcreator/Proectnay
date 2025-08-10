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


    signal sendPicture(string picture)
    onSendPicture: pageLoader.item.img.source = picture
    function startAnimation(newTarget) {
        myAnimationStart.target = newTarget
        myAnimationStart.start()
    }
    function closeAnimation(newTarget,toValue) {
        myAnimationClose.target = newTarget
        myAnimationClose.to = -toValue
        myAnimationClose.start()
    }

    Rectangle {
        id:mainRect
        anchors.fill: parent
        color: Qt.rgba(248/255,232/255,233/255,1)
        Button {
            id:but
            x:0
            y:50
            onClicked: myModel.setImageToDB()
            enabled: true
        }
//        Button {
//            anchors.left: but.right
//            onClicked: myModel.loadFromDatabase()
//            enabled: false
//        }


        Rectangle {       ///////CustomToll
            width: parent.width + 4
            height: 66
            border.color: "white"
            border.width: 2
            anchors.top: parent.top
            anchors.topMargin: -2
            anchors.left: parent.left
            anchors.leftMargin: -2
            color: Qt.rgba(26/255,26/255,26/255,1)
            Image {
                id: categoriiButton
                x:8
                y:7
                source: "qrc:/assets/image/Hamburger_LG.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mainRect.enabled = false
                        fonShowAnimation.start()
                        startAnimation(sidePanelItem)
                    }
                }
            }
            Image {
                id: adminButton
                anchors.right: parent.right
                source: "qrc:/assets/image/Hamburger_LG.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                            stackPage.push(myTimer)
                    }
                }
            }
        }

        Label {
            id: labelMain
            x:8
            y:72
            text: "Главная"
            font.pixelSize: 30
            color: Qt.rgba(46/255,46/255,46/255,1)
        }

        ListView { ////////////////////INSRTUMENTI
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

        Label {
            x:9
            y:242
            width: 230
            height: 64
            id: labelWhatNeed
            text: "Что хотите"
            font.pixelSize: 30
            color: Qt.rgba(46/255,46/255,46/255,1)
        }

        ListView {     ///////////ZAVTRAKI
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

        Label {
            x:9
            y:428
            width: 220
            height: 64
            id: labelRecepie
            text: "Рецепты"
            font.pixelSize: 30
            color: Qt.rgba(46/255,46/255,46/255,1)
        }

        GridView { //////////////////VODEL
            id:mainListView
            anchors.left: parent.left
            anchors.leftMargin: 18
            y:490
            width: 428
            height: 345
            cellWidth: 174+30;
            cellHeight: 143+30

            model: myModel
            clip: true

            delegate: Item {
                id:delegateItem
                height: 143
                width:174
                DropShadow {
                    anchors.fill: delegate
                    source: delegate      // Источник тени (наш Rectangle)
                    horizontalOffset: 3      // Смещение по X
                    verticalOffset: 3       // Смещение по Y
                    radius: 10              // Размытие тени
                    samples: 17             // Качество (чем больше, тем плавнее)
                    color: "#80000000"      // Цвет тени (черный с прозрачностью 50%)
                }
                Rectangle {
                    id:delegate
                    height: 143
                    width: 174
                    color:Qt.rgba(255/255,211/255,181/255,1)
                    clip: true
                    Rectangle {
                        id:imgdel
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 2
                        height: 112
                        radius:6.5
                        clip: true
                        border.color:Qt.rgba(255/255,211/255,181/255,1)
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                previewRecepie.titleImage = delegateImage.source
                                myListModel.loadDataFromDB(textItem.text);
                                myListModel.loadTitleText(textItem.text);

                            }
                        }

                        Image {
                            id:delegateImage
                            anchors.fill: imgdel
                            source: imageRole
                            fillMode: Image.PreserveAspectCrop
                            visible: true
                        }
                    }
                    Rectangle {
                        anchors.top: imgdel.bottom
                        height: 31
                        width: parent.width
                        color: Qt.rgba(201/255,55/255,86/255,1);
                        border.color: Qt.rgba(255/255,211/255,181/255,1)
                        border.width: 1
                        Text {
                            anchors.centerIn: parent
                            id:textItem
                            text: name
                            font.bold: true
                            width: parent.width
                            elide: Text.ElideRight
                            font.pointSize: 6
                            color: "white"
                        }
                    }
                }
            }
        }
        NavigatePanel {
            anchors.bottom: parent.bottom
            id:myBottomPanel
            onShowProfil: {

                ////////
                pageLoader.source = "Profil.qml"
                startAnimation(pageLoader)
                mainRect.enabled = false
                pageLoader.item.nameQml = sendName
                pageLoader.item.lastNameQml = sendLastName
                pageLoader.item.loginQml = sendLogin
                pageLoader.item.passwordQml = sendPassword

            }
            onSeachName: {
                seach.visible = true
                offSeachFon.visible = true
                mainRect.enabled = false
            }
        }

        NumberAnimation { //showAnimation
            id:myAnimationStart
            targets: test
            properties: "x"
            to: 0
            duration: 200
        }

        NumberAnimation {//CloseFonAnimationSide
            id:fonShowAnimation
            target: offSidepanelFon
            property: "opacity"
            to:0.5
            duration: 200
            easing.type: Easing.InOutQuad
            onStarted: offSidepanelFon.visible = true
        }
        NumberAnimation {//CloseFonAnimationSide
            id:fonSloseAnimation
            target: offSidepanelFon
            property: "opacity"
            to:0
            duration: 200
            easing.type: Easing.InOutQuad
            onStopped: {
                offSidepanelFon.visible = false
                mainRect.enabled = true
            }
        }

        NumberAnimation { //closeAnimation
            id:myAnimationClose
            target: test
            property: "x"
            to:-428
            duration: 200
            onStopped:  {
                mainRect.enabled = true
                pageLoader.source = ""
            }
        }
    }
    Rectangle {    ///////////////FON
        id:offSeachFon
        anchors.fill: parent
        color: "black"
        opacity: 0.5
        visible: false
        MouseArea {
            anchors.fill: parent
            onClicked: {
                offSeachFon.visible = false
                mainRect.enabled = true
                seach.visible = false
            }
        }
    }
    SeachItem {
        id:seach
        anchors.centerIn: parent
        width: parent.width
        height: 301
        visible: false
        onPoisk: {
            seach.visible = false
            offSeachFon.visible = false
            mainRect.enabled = true
        }
    }
    Rectangle {    ///////////////FON
        id:offSidepanelFon
        anchors.fill: parent
        color: "black"
        opacity: 0
        visible: false
        MouseArea {
            height: parent.height
            width:parent.width - sidePanelItem.width
            x:sidePanelItem.width
            y:0
            onClicked: {
                fonSloseAnimation.start()
                closeAnimation(sidePanelItem,sidePanelItem.width)
            }
        }
    }
    MySidePanelItem {
        id: sidePanelItem
        x:-269
        y:0
        height: parent.height
        width: 269
    }

    Rectangle {
        id:test
        enabled: false
        visible: false
        anchors.fill: parent
        color: "white"
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
            closeAnimation(pageLoader,428)
        }
        onOpenFileProvider: {
            if(!fileDialog.visible) {
                fileDialog.open()
            }
            else console.log("Not open")
        }
    }
}
