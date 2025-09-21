#ifndef ADDIGREDIENT_H
#define ADDIGREDIENT_H

#include <QObject>
#include <QStringListModel>
class AddIgredient:public QObject
{
    Q_OBJECT
public:
    explicit AddIgredient(QObject*parent = nullptr);
    Q_INVOKABLE  QVariantList  searchIngredients(const QString &prefix) ;

};

#endif // ADDIGREDIENT_H
