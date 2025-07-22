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
    QSqlQuery query("SELECT * FROM users");

    if (!query.isActive()) {
        qDebug() << "Ошибка выполнения запроса:" << query.lastError().text();
    }
    myModel->clear();
    while (query.next()) {
        QString name = query.value("username").toString();
        QString email = query.value("email").toString();
        QStandardItem *item1 = new QStandardItem(name);
        QStandardItem *item2 = new QStandardItem(email);
        myModel->appendRow({item1, item2});
    }
    qDebug()<<"1";
    qDebug()<<QSqlDatabase::drivers();
}
