#ifndef MYMODEL_H
#define MYMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QStandardItemModel>
#include <authorizacia.h>

#define TABLE                   "recepies"       // Название таблицы
#define TABLE_NAME              "Name"              // Вторая колонка
#define TABLE_PIC               "Img"

class MyModel:public QAbstractListModel
{
    Q_OBJECT
public:

    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        ImageRole
    };

    explicit MyModel(QObject*parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void setImageToDB(const QString &urlPath,QString id,QString title,QString description);
    Q_INVOKABLE void loadFromDatabase();
    Q_INVOKABLE void seachName(QString title,QString parametr);
    Q_INVOKABLE void refreshModel();
    QByteArray getDefaultImage() const;
    QByteArray getCompressedImage(const QByteArray& original) const;
    bool insertDataToDB(const QVariantList &data);
    bool insetIntoTable(const QString &name,const QString &lastName,const QString &id, const QByteArray &img);

private:
    struct Item {
        int id;
        QString name;
        QByteArray image;
    };
    QList<Item> m_items;
signals:
    void myModelChanged();
    void myModelCreate();
};

#endif // MYMODEL_H
