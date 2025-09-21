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
    Q_INVOKABLE void addIngredient(QString titleRecepie,QString ingredient,QString valueIngridient);
    Q_INVOKABLE void loadDataFromDB(QString titleRecepie);
    Q_INVOKABLE void loadTitleText(QString titleRecepie);
    Q_INVOKABLE void deleteIngredient(QString titleRecepie,QString ingredient);
private:
    QVector<IngredientItem> m_items;
signals:
    void textTileRecepie(QString titleTextC);
};

#endif // INGREDIENTLISTMODEL_H
