import QtQuick 2.12
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import AuthorizaciaClass 1.0
import SignUp 1.0
ApplicationWindow {
    id:mainWindow
    width: 428
    height: 926
    visible: true
    property string statusQml: ""
    StackView {
        id:stackPage
        initialItem: authorizaciaQml
    }
    AuthorizaciaClass {
        id:authorizaciaClass
        onMyLoginAndPassFinded: {
            console.log("Данные найдены");
            stackPage.push(registraciaQml)
        }
    }
    Authorizacia {
        id:authorizaciaQml
    }
    Registracia {
        visible: false
        id:registraciaQml
    }
    SignUp {
        id:signUp
        onStatusSignUp: {
            statusQml = status;
            console.log(status)
        }
    }
}
