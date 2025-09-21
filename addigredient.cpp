#include "addigredient.h"
#include "authorizacia.h"
AddIgredient::AddIgredient(QObject*parent):QObject(parent)
{

}

QVariantList AddIgredient::searchIngredients(const QString &prefix)
{
    QVariantList results;
    QString connectionName = QString("temp_connection_%1").arg(QTime::currentTime().msec());
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL", connectionName);
    db.setHostName("localhost");
    db.setPort(5432);
    db.setDatabaseName("datamy1");
    db.setUserName("postgres");
    db.setPassword("1234");

    QSqlQuery query;
    query.prepare("SELECT name FROM ingredients WHERE name ILIKE :p LIMIT 10");
    query.bindValue(":p", prefix + "%");

    if (!query.exec()) {
        qWarning() << "SQL error:" << query.lastError().text();
        return results; // возвращаем пустой список
    }

    while (query.next()) {
        // Более безопасное получение значения
        QVariant value = query.value(0);
        if (!value.isNull() && value.isValid()) {
            results << value.toString();
        }
    }

    qDebug() << "Found" << results.size() << "suggestions";
    return results;
}


