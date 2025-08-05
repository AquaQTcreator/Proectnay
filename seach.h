#ifndef SEACH_H
#define SEACH_H

#include <QObject>
#include "authorizacia.h"
class seach:public QObject
{
    Q_OBJECT
public:
    explicit seach(QObject*parent = nullptr);

    Q_INVOKABLE void seachName(QString title);
};

#endif // SEACH_H
