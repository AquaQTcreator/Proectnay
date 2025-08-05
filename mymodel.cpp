#include "mymodel.h"
#include <QBuffer>
#include <QFileInfo>
#include <QSql>
MyModel::MyModel(QObject*parent):QAbstractListModel(parent)
{

}

void MyModel::setImageToDB()
{
    QString source = "D:\\рабочий стол\\Projects\\Личное\\Кисляй\\Снимок экрана 2025-04-19 205202.png";
    QPixmap myPixmap(source);
    QByteArray myByteArray;
    QBuffer inBuffer(&myByteArray);

    inBuffer.open(QIODevice::WriteOnly);
    myPixmap.save(&inBuffer, "PNG");

    QString fileName = QFileInfo(source).fileName();
    if (!insetIntoTable(fileName, myByteArray)) {
        qDebug() << "Ошибка: не удалось вставить данные в таблицу";
        return;
    }

    qDebug() << "Изображение успешно вставлено в базу";
}

bool MyModel::insertDataToDB(const QVariantList &data)
{
    /* Запрос SQL формируется из QVariantList,
         * в который передаются данные для вставки в таблицу.
         * */
        QSqlQuery query;
        query.prepare(QString("INSERT INTO %1 (%2, %3) VALUES (:Name, :Img)")
                      .arg(TABLE)
                      .arg(TABLE_NAME)
                      .arg(TABLE_PIC));

        query.bindValue(":Name", data[0].toString());
        query.bindValue(":Img", data[1].toByteArray());

        if (!query.exec()) {
            qDebug() << "Error inserting into " << TABLE << ":" << query.lastError().text();
            return false;
        }
        return true;
}

bool MyModel::insetIntoTable(const QString &name, const QByteArray &img)
{
    QVariantList data;
    data.append(name);
    data.append(img);

    return insertDataToDB(data);
}

int MyModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_items.count();
}
QHash<int, QByteArray> MyModel::roleNames() const
{
    return {
        { IdRole, "id" },
        { NameRole, "name" },
        { ImageRole, "imageRole" }
    };
}
QVariant MyModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.count())
        return QVariant();

    const Item &item = m_items.at(index.row());

    switch (role) {
    case IdRole:
        return item.id;
    case NameRole:
        return item.name;
    case ImageRole:
        // Формируем data URI для QML Image
        return "data:image/png;base64," + QString::fromLatin1(item.image.toBase64());
    default:
        return QVariant();
    }
}
void MyModel::loadFromDatabase()
{
    beginResetModel();
    m_items.clear();

    QSqlQuery query;
    QString sql = "SELECT id, Name, Img FROM ImageTable";
    qDebug() << "Executing SQL:" << sql;

    if (!query.exec(sql)) {
        qDebug() << "Error loading data:" << query.lastError().text();
    }else {
        while (query.next()) {
            Item item;
            item.id = query.value(0).toInt();
            item.name = query.value(1).toString();
            item.image = query.value(2).toByteArray();
            m_items.append(item);
        }
    }
    endResetModel();
    emit myModelCreate();
}

void MyModel::seachName(QString title,QString parametr)
{
    beginResetModel();
    m_items.clear();
    title = "Снимок экрана 2025-05-11 131944.png";
    QSqlQuery query;
    query.exec("SELECT id,Name,Img FROM ImageTable Where "+parametr+" = '"+title+"'");
    while (query.next()) {
        Item item;
        item.id = query.value(0).toInt();
        item.name = query.value(1).toString();
        item.image = query.value(2).toByteArray();
        m_items.append(item);
    }
    endResetModel();

}
