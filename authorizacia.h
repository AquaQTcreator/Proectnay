#ifndef AUTHORIZACIA_H
#define AUTHORIZACIA_H

#include <QObject>
#include <QSqlDatabase>
#include <QtSql>
#include <QStandardItemModel>
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
};

#endif // AUTHORIZACIA_H
