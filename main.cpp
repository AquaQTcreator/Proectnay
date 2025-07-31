#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "authorizacia.h"
#include "signup.h"
#include <QQmlContext>
#include "mymodel.h"
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<Authorizacia>("AuthorizaciaClass",1,0,"AuthorizaciaClass");
    qmlRegisterType<SignUp>("SignUp",1,0,"SignUp");
    qmlRegisterType<MyModel>("MyModel",1,0,"MyModel");
  //  MyModel* model = new MyModel();

   // engine.rootContext()->setContextProperty("myModel", model);
    engine.load(url);
    return app.exec();
}
