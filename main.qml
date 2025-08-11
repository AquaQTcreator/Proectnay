import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import Qt.labs.platform 1.1
import AuthorizaciaClass 1.0
import SignUp 1.0
import MyModel 1.0
ApplicationWindow {
    id:mainWindow
    width: 428
    height: 926
    visible: true
    property string statusQml: ""
    property string idUser: "1"
    property string myTitle: ""
    property string description: ""
    Connections {
        target: myListModel
        onTextTileRecepie: {
            previewRecepie.titleText = titleTextC
            stackPage.push(previewRecepie)
        }
    }

    StackView {
        id:stackPage
        initialItem: authorizaciaQml

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
    }

    AuthorizaciaClass {
        id:authorizaciaClass
        onMyLoginAndPassFinded: {
            console.log("Данные найдены");
            myModel.loadFromDatabase()
            mainMenuQml.sendName = name;
            mainMenuQml.sendLastName = lastName;
            mainMenuQml.sendLogin = login;
            mainMenuQml.sendPassword = password;
        }
    }
    Authorizacia {
        id:authorizaciaQml
        visible: false
    }
    Registracia {
        visible: false
        id:registraciaQml
    }
    MainMenu {
        id:mainMenuQml
        visible: false
    }
    SignUp {
        id:signUp
        onStatusSignUp: {
            statusQml = status;
        }
    }
    MyModel {
        id:myModel
        onMyModelCreate: stackPage.push(mainMenuQml)
    }
    FileDialog {
        id:fileDialog
        folder:"file:///D:/Pictures/"
        nameFilters: ["PNG Files (*.png)"]
        onAccepted: {
            profilUser.setImageToDB(fileDialog.file);
//
            console.log(fileDialog.file)
            //mainMenuQml.sendPicture(fileDialog.file)
     //       profil.visible = true
        }
}
    FileDialog {
        id:fileDialog1
        folder:"file:///D:/Pictures/"
      //  nameFilters: ["PNG Files (*.png)"]
        onAccepted: {
            console.log(myTitle)
            console.log(description)
            console.log(idUser)
            myModel.setImageToDB(fileDialog1.file,idUser,myTitle,description)
            console.log(fileDialog1.file)
            fileDialog1.close()
            //mainMenuQml.sendPicture(fileDialog.file)
     //       profil.visible = true
        }
}
    TimerPage {
        id:myTimer
        visible: false
    }
    PrewieIngridients {
        id:preview
        visible: false
    }
    PreviewRecepie {
        id:previewRecepie
        visible: false
    }
    AddPagePreview {
        id:addPreview
        visible: false
    }
}
