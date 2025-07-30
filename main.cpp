#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "authorizacia.h"
#include "signup.h"
#include "mymodel.h"
#include <QQmlContext>
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    ImageGet* provider = new ImageGet;
     MyModel* model = new MyModel;
    model->setProvider(provider);
        engine.addImageProvider("dbimage", provider);
          engine.rootContext()->setContextProperty("myModel", model);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

        qmlRegisterType<Authorizacia>("AuthorizaciaClass",1,0,"AuthorizaciaClass");
        qmlRegisterType<SignUp>("SignUp",1,0,"SignUp");
    engine.load(url);
    return app.exec();
}
