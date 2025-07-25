#include "authorizacia.h"
#include "QDebug"

Authorizacia::Authorizacia(QObject *parent) : QObject(parent)
{
    db.setHostName("localhost");
    db.setPort(5432);
    db.setDatabaseName("datamy1");
    db.setUserName("postgres");
    db.setPassword("1234");

    if (!db.open()) {
        qDebug() << "Ошибка подключения:" << db.lastError().text();
    } else {
        qDebug() << "Подключение успешно!";
    }

    myModel = new QStandardItemModel(0, 2, this);
    myModel->setHorizontalHeaderLabels({ "login" , "email" });
}

void Authorizacia::getDataAutorizacia(QString login, QString password)
{
//    QSqlQuery query("SELECT * FROM users");
//    if (!query.isActive()) {
//        qDebug() << "Ошибка выполнения запроса:" << query.lastError().text();
//    }
//    myModel->clear();
//    while (query.next()) {
//         login = query.value("username").toString();
//         password = query.value("email").toString();
//        QStandardItem *item1 = new QStandardItem(login);
//        QStandardItem *item2 = new QStandardItem(password);
//        myModel->appendRow({item1, item2});
//    }
        QSqlQuery query;
        query.prepare("SELECT EXISTS (SELECT 1 FROM users WHERE email = '"+SignUp::dataToHash(login)+"' AND password = '"+SignUp::dataToHash(password)+"')");
        if (query.exec() && query.next()) {
        if (query.value(0).toBool()) emit myLoginAndPassFinded();
        }
}
