#include <QApplication>
#include <QQmlApplicationEngine>
#include "authorizacia.h"
#include "signup.h"
#include <QQmlContext>
#include "mymodel.h"
#include "profiluser.h"
#include "ingredientlistmodel.h"
#include "addigredient.h"
static MyModel myModel;

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    profilUser myProfil;
    engine.rootContext()->setContextProperty("profilUser",&myProfil);
    IngredientListModel myIngredientsModel;
    engine.rootContext()->setContextProperty("myListModel",&myIngredientsModel);
    AddIgredient myAddIngreadientModel;
    engine.rootContext()->setContextProperty("addIngredientModel",&myAddIngreadientModel);
    engine.rootContext()->setContextProperty("myMainModel",&myModel);
    qmlRegisterType<Authorizacia>("AuthorizaciaClass",1,0,"AuthorizaciaClass");
    qmlRegisterType<SignUp>("SignUp",1,0,"SignUp");
  //  MyModel* model = new MyModel();

   // engine.rootContext()->setContextProperty("myModel", model);
    engine.load(url);
    return app.exec();
}
