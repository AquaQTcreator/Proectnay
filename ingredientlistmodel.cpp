#include "ingredientlistmodel.h"

IngredientListModel::IngredientListModel(QObject*parent):QAbstractListModel(parent)
{

}

int IngredientListModel::rowCount(const QModelIndex &parent) const
{
 Q_UNUSED(parent)
    return m_items.size();
}

QVariant IngredientListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.row() < 0 || index.row() >= m_items.size() )
        return QVariant();

    const IngredientItem &item = m_items.at(index.row());

    switch (role) {
    case ValueRole:
        return item.value;
     case UnitRole:
        return item.unit;
     case IngredientRole:
        return item.ingredient;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> IngredientListModel::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[ValueRole] = "value";
    roles[UnitRole] = "unit";
    roles[IngredientRole] = "ingredient";
    return roles;
}

void IngredientListModel::loadDataFromDB(QString titleRecepie)
{
    beginResetModel();
    m_items.clear();
    QSqlQuery queryId;
    QString idRecepie;
    queryId.prepare("SELECT id FROM recepies WHERE name_recepie = '"+titleRecepie+"'");
    queryId.exec();
    queryId.next();
    idRecepie = queryId.value(0).toString();
    QSqlQuery query;
    query.prepare(R"(
              SELECT ri.value,u.name AS unit,i.name AS ingredient
              FROM recepie_ingridients ri
              JOIN ingredients i ON ri.ingredient_id = i.id
              JOIN units u ON ri.unit_id = u.id
              WHERE ri.recepie_id = :recepieId
              ORDER BY i.name;)");
    query.bindValue(":recepieId",idRecepie);
                if(!query.exec()) {
                    qDebug() << "Fail" <<query.lastError();
                    endResetModel();
                    return;
                }
                while (query.next()) {
                    IngredientItem item;
                    item.value = query.value("value").toString();
                    item.unit = query.value("unit").toString();
                    item.ingredient = query.value("ingredient").toString();
                    m_items.append(item);
                }
                endResetModel();
}


