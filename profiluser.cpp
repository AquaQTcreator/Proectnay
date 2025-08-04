#include "profiluser.h"
#include "authorizacia.h"
profilUser::profilUser(QObject*parent):QObject(parent)
{

}
void profilUser::setImageToDB(const QString &urlPath)
{
    QUrl fileUrl(urlPath);
    QString source = fileUrl.toLocalFile();
    QPixmap myPixmap(source);
    QByteArray myByteArray;
    QBuffer inBuffer(&myByteArray);

    inBuffer.open(QIODevice::WriteOnly);
    myPixmap.save(&inBuffer, "PNG");

    QString fileName = QFileInfo(source).fileName();
    QString lastName = "Chislov";
    if (!insetIntoTable(fileName,lastName, myByteArray)) {
        qDebug() << "Ошибка: не удалось вставить данные в таблицу";
        return;
    }

    qDebug() << "Изображение успешно вставлено в базу";
    emit changedPhoto();
}

bool profilUser::insertDataToDB(const QVariantList &data)
{
    /* Запрос SQL формируется из QVariantList,
         * в который передаются данные для вставки в таблицу.
         * */

        QSqlQuery query;
        query.prepare("UPDATE profilTable SET photo = :Photo WHERE id = :id");
        query.bindValue(":Photo", data[2].toByteArray());
        query.bindValue(":id", 7);

        if (!query.exec()) {
            qDebug() << "Ошибка обновления фото:" << query.lastError().text();
            return false;
        }

        return true;
}

bool profilUser::insetIntoTable(const QString &name,const QString &lastName, const QByteArray &img)
{
    QVariantList data;
    data.append(name);
    data.append(lastName);
    data.append(img);

    return insertDataToDB(data);
}
QString profilUser::getUserPhoto(int id)
{
    QSqlQuery query;
    query.prepare("SELECT photo FROM profilTable WHERE id = :id");
    query.bindValue(":id", id);

    if (!query.exec()) {
        qDebug() << "Ошибка запроса:" << query.lastError().text();
        return "";
    }

    if (query.next()) {
        QByteArray imageData = query.value(0).toByteArray();
        QString base64 = QString::fromLatin1(imageData.toBase64());
        return "data:image/png;base64," + base64;
    }

    return "";
}
