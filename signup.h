#ifndef SIGNUP_H
#define SIGNUP_H

#include <QObject>
#include "authorizacia.h"
class SignUp:public QObject
{
    Q_OBJECT
public:
    explicit SignUp(QObject*parent = nullptr);
    Q_INVOKABLE void getDataForSignUp(QString name,QString lastname,QString login,QString password);
    static QString dataToHash(QString dataToHash);

signals:
    void statusSignUp(QString status);
};

#endif // SIGNUP_H
