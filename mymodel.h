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
    Q_PROPERTY(int currentPage READ currentPage NOTIFY pageChanged)
    Q_PROPERTY(int totalPages READ totalPages NOTIFY totalPagesChanged)
    Q_PROPERTY(bool hasNextPage READ hasNextPage NOTIFY pageChanged)
    Q_PROPERTY(bool hasPreviousPage READ hasPreviousPage NOTIFY pageChanged)
    Q_PROPERTY(int totalItems READ totalItems NOTIFY totalItemsChanged)
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

    Q_INVOKABLE void loadNextPage();
    Q_INVOKABLE void loadPreviousPage();
    Q_INVOKABLE void refreshData();

    int currentPage() const { return m_currentPage; }
    int totalPages() const { return m_totalPages; }
    int totalItems() const { return m_totalItems; }
    bool hasNextPage() const ;
    bool hasPreviousPage() const { return m_currentPage > 0; }

    QByteArray getDefaultImage() const;
    QByteArray getCompressedImage(const QByteArray& original) const;
    bool insertDataToDB(const QVariantList &data);
    bool insetIntoTable(const QString &name,const QString &lastName,const QString &id, const QByteArray &img);

private:
    void loadPage(int page);
    void calculateTotalPages();
    struct Item {
        int id;
        QString name;
        QByteArray image;
    };
    int m_currentPage = 0;
    int m_totalPages = 0;
    int m_totalItems = 0;
    const int ITEMS_PER_PAGE = 8;
    int m_offset = 0;
    QList<Item> m_items;
signals:
    void myModelChanged();
    void myModelCreate();
    void pageChanged();
    void totalPagesChanged();
    void totalItemsChanged();
};

#endif // MYMODEL_H
