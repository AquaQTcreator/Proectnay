#ifndef INGREDIENTLISTMODEL_H
#define INGREDIENTLISTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include "authorizacia.h"
struct IngredientItem {
    QString value;
    QString unit;
    QString ingredient;
};

class IngredientListModel:public QAbstractListModel
{
    Q_OBJECT
public:
    explicit IngredientListModel(QObject*parent = nullptr);

    enum IngredientRoles {
        ValueRole = Qt::UserRole+1,
        UnitRole,
        IngredientRole,
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole ) const override;
    QHash<int , QByteArray> roleNames() const override;
    Q_INVOKABLE void loadDataFromDB(QString titleRecepie);

private:
    QVector<IngredientItem> m_items;
};

#endif // INGREDIENTLISTMODEL_H
