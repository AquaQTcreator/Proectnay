import QtQuick 2.0
import QtQuick.Controls 2.12
Item {
    width: 428
    height: 926
    property string mainLabel: "Для начала придумайте название блюда:"
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
        id:txtTitle
        x:19
        y:197
        width: 324
        height: 61
        background: Rectangle {
            anchors.fill: parent
            radius: 10
        }
    }
    Text {
        x:15
        y:287
        text:"Напишите описание:"
        font {
            bold: true
            pixelSize: 30
            styleName: "Inter"
        }
    }
    TextField {
        id:txtDescription
        x:15
        y:327
        width: 396
        height: 209
        background: Rectangle {
            anchors.fill: parent
            radius: 10
            Button {
                id:sendWithImg
                text: "OK"
                anchors.bottom: parent.bottom
                anchors.right:  parent.right
                onClicked: {
                    if(txtTitle.text === "" || txtDescription.text === "") console.log("Напишите текст")
                    else {
                        mainWindow.myTitle = txtTitle.text
                        console.log(txtTitle.text)
                        mainWindow.description = txtDescription.text
                        if(!fileDialog1.visible) {
                            fileDialog1.open()
                        }
                        else console.log("Not open")
                    }
                }
            }
            Button {
                text: "NEOK"
                anchors.bottom: parent.bottom
                anchors.right:  sendWithImg.left
                onClicked: {
                    if(txtTitle.text === "" || txtDescription.text === "") console.log("Напишите текст")
                    else {
                        myModel.setImageToDB(fileDialog1.file,1,txtTitle.text,txtDescription.text)
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


