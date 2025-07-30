import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Window 2.12
Window {
    height: mainWindow.height
    width: mainWindow.width
    Button {
        x:0
        y:50
//        onClicked: myModelClass.getImage();
    }
    Image {
        id: imageView
        width: parent.width
        height: 400
        fillMode: Image.PreserveAspectFit
        source: ""

        Component.onCompleted: {
            // Сначала загружаем картинку
            myModel.getImage()

            // Потом "перезагружаем" source (отложено на след. кадр)
            Qt.callLater(() => imageView.source = "image://dbimage/test")
        }
    }
}
