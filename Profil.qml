import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    height: 926
    width: 428
    id:profilItem
    signal closeThisItem()
    Rectangle{
        anchors.fill: parent
        color: "white"
        Button {
            anchors.centerIn: parent
            onClicked: {
                console.log("ckic")
                closeThisItem()
            }
        }
    }
}
