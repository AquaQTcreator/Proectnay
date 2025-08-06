#ifndef PROFILUSER_H
#define PROFILUSER_H

#include <QObject>

class profilUser:public QObject
{
    Q_OBJECT

public:
    explicit  profilUser(QObject*parent = nullptr);
    Q_INVOKABLE void setImageToDB(const QString &urlPath);
    Q_INVOKABLE QString getUserPhoto(int id);
    bool insertDataToDB(const QVariantList &data);
    bool insetIntoTable(const QString &name,const QString &lastName, const QByteArray &img);
signals:
    void changedPhoto();
};

#endif // PROFILUSER_H
