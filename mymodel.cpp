#include "mymodel.h"

MyModel::MyModel(QObject*parent):QObject(parent)
{

}

void MyModel::sendImage()
{
    QString filePath = "D:/рабочий стол/Projects/Личное/Бс/IMG_20240913_205747_760.jpg";
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Не удалось открыть файл:" << file.errorString();
    }

    QByteArray imageData = file.readAll();
    file.close();

    // Подготовка запроса
    QSqlQuery query;
    query.prepare("INSERT INTO photos (name, image) VALUES (:name, :image)");
    query.bindValue(":name", "IMG_20240913_205747_760");
    query.bindValue(":image", imageData);

    if (!query.exec()) {
        qDebug() << "Ошибка выполнения запроса:" << query.lastError().text();
    }

    qDebug() << "Изображение успешно добавлено в базу данных.";

}
void MyModel::setProvider(ImageGet *provider) {
    m_provider = provider;
}
void MyModel::getImage()
{
    qDebug() << "1";

    if (!m_provider) {
        qDebug() << "❌ m_provider не установлен!";
        return;
    }

    if (!QSqlDatabase::database().isOpen()) {
        qDebug() << "❌ База данных не подключена!";
        return;
    }

    QSqlQuery query;
    query.prepare("SELECT image FROM photos WHERE name = :name");
    query.bindValue(":name", "IMG_20240913_205747_760");

    if (!query.exec()) {
        qDebug() << "❌ Ошибка запроса:" << query.lastError().text();
        return;
    }

    if (!query.next()) {
        qDebug() << "⚠️ Нет строки с таким именем изображения.";
        return;
    }

    QByteArray imgData = query.value(0).toByteArray();
    QImage img;
    img.loadFromData(imgData);

    if (img.isNull()) {
        qDebug() << "❌ Картинка не загружена. Возможно, повреждённые данные.";
        return;
    }

    qDebug() << "✅ Картинка загружена:" << img.size();
    m_provider->setImage(img);
}
