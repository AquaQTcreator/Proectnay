#ifndef AUTHORIZACIA_H
#define AUTHORIZACIA_H

#include <QObject>
#include <QSqlDatabase>
#include <QtSql>
#include <QStandardItemModel>
#include "signup.h"

class Authorizacia : public QObject
{
    Q_OBJECT
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");
    Q_PROPERTY(QStandardItemModel*myModel READ getMyModel WRITE setMyModel NOTIFY myModelChanged);
public:
    explicit Authorizacia(QObject *parent = nullptr);

    Q_INVOKABLE void getDataAutorizacia(QString login, QString password);

    QStandardItemModel*getMyModel(){
        return myModel;
    }
    Q_INVOKABLE void setMyModel(
            QStandardItemModel*model){
        myModel=model;
    }

private:
    QStandardItemModel*myModel;

signals:
    void myModelChanged();
    void myLoginAndPassFinded(QString name, QString lastName, QString login, QString password);
    void myProfil(QString name, QString lastName);
};

#endif // AUTHORIZACIA_H
