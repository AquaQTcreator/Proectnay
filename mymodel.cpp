#include "mymodel.h"
#include <QBuffer>
#include <QFileInfo>
#include <QSql>
MyModel::MyModel(QObject*parent):QAbstractListModel(parent)
{

}

void MyModel::setImageToDB(const QString &urlPath,QString id,QString title,QString description)
{
    QUrl fileUrl(urlPath);
    QString source = fileUrl.toLocalFile();
    QPixmap myPixmap(source);
    QByteArray myByteArray;
    QBuffer inBuffer(&myByteArray);

    inBuffer.open(QIODevice::WriteOnly);
    QString format = "PNG"; // формат по умолчанию
    QString extension = QFileInfo(source).suffix().toLower();
//    QFileInfo(source) — создает объект QFileInfo для анализа пути к файлу (source).

//    .suffix() — возвращает расширение файла (например, "jpg" для "image.jpg").

//    .toLower() — преобразует расширение в нижний регистр (например, "JPG" → "jpg").
    if (extension == "jpg" || extension == "jpeg") {
        format = "JPG";
    } else if (extension == "png") {
        format = "PNG";
    } else {
        qDebug() << "Неизвестный формат изображения, будет использован PNG";
    }

    // Сохраняем в соответствующем формате
    if (!myPixmap.save(&inBuffer, format.toStdString().c_str())) {
        qDebug() << "Ошибка при сохранении изображения в формате" << format;
 //       return; //c_str это констчар
    }
     QString title_db = title;
     QString description_db = description;
     QString id_db = id;
 //    QString fileName = QFileInfo(source).fileName();
    if (!insetIntoTable(title_db,description_db,id_db, myByteArray)) {
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
        query.prepare("INSERT INTO recepies (name_recepie, photo_recepie, category_id, author_id, description)"
                      "VALUES (:Name, :Photo, 1, :Id, :Description);");
        query.bindValue(":Name",data[0].toString());
        query.bindValue(":Description",data[1].toString());
        query.bindValue(":Photo", data[3].toByteArray());
        query.bindValue(":Id", data[2].toString());

        if (!query.exec()) {
            qDebug() << "Ошибка обновления фото:" << query.lastError().text();
            query.prepare("INSERT INTO recepies (name_recepie, photo_recepie, category_id, author_id, description)"
                          "VALUES (:Name, NULL, 1, :Id, :Description);");
            query.bindValue(":Name",data[0].toString());
            query.bindValue(":Description",data[1].toString());
            query.bindValue(":Id", data[2].toString());
            if(!query.exec()){
               qDebug() << "Ошибка обновления фото:" << query.lastError().text();
               return false;
            }
            else {
                qDebug() << "Добавлено без фото";
                return true;
            }
            return false;
        }

        return true;
}

bool MyModel::insetIntoTable(const QString &name,const QString &lastName,const QString &id, const QByteArray &img)
{
    QVariantList data;
    data.append(name);
    data.append(lastName);
    data.append(id);
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
void MyModel::loadFromDatabase() // Заполняю структуру item для модели
{
    beginResetModel();
    m_items.clear();

    QSqlQuery query;
    QString sql = "SELECT name_recepie, photo_recepie FROM recepies";
    qDebug() << "Executing SQL:" << sql;

    if (!query.exec(sql)) {
        qCritical() << "Error loading data:" << query.lastError().text();
        endResetModel();  // Важно вызвать даже при ошибке
        return;
    }

    while (query.next()) {
        Item item;
        item.name = query.value(0).toString();

        // Обработка изображения
        QVariant imageData = query.value(1);

        if (imageData.isNull() || imageData.toByteArray().isEmpty()) {
            qDebug() << "Фото отсутствует (NULL), загружаем замену";

            // 1. Используем ресурсы Qt вместо абсолютного пути
            QString defaultImagePath = ":/assets/image/dinner.png"; // Поместите изображение в qrc

            // 2. Безопасная загрузка
            QFile file(defaultImagePath);
            if (file.open(QIODevice::ReadOnly)) {
                item.image = file.readAll();
                file.close();
            } else {
                qWarning() << "Не удалось загрузить изображение по умолчанию";
                item.image = QByteArray(); // Пустой массив
            }
        } else {
            // Проверка валидности изображения из БД
            QByteArray imgData = imageData.toByteArray();
            QImage testImage;

            if (!testImage.loadFromData(imgData)) {
                qWarning() << "Некорректные данные изображения в БД";
                item.image = QByteArray();
            } else {
                item.image = imgData;
                qDebug() << "Изображение загружено, размер:" << imgData.size() << "байт";
            }
        }

        m_items.append(item);
    }

    endResetModel();
    emit myModelCreate();

    // Дополнительная проверка
    qDebug() << "Модель обновлена, элементов:" << m_items.size();
//    beginResetModel();
//    m_items.clear();

//    QSqlQuery query;
//    QString sql = "SELECT name_recepie, photo_recepie FROM recepies";
//    qDebug() << "Executing SQL:" << sql;

//    if (!query.exec(sql)) {
//        qDebug() << "Error loading data:" << query.lastError().text();
//    }else {
//        while (query.next()) {
//            Item item;
//            item.name = query.value(0).toString();

//            QVariant imageData = query.value(1); // Получаем данные изображения

//            if (imageData.isNull()) {   //Проверка на пустоту и если пустое то загружаю мамикона
//                qDebug() << "Фото отсутствует (NULL)";
//                QString source = "D:/рабочий стол/Projects/Личное/Кисляй/Снимок экрана 2025-05-11 131944.png";
//                QFile file(source);
//                if (!file.open(QIODevice::ReadOnly)) {
//                    qDebug() << "Ошибка: не удалось открыть файл" << source; // Возвращаем пустой QByteArray
//                }
//                QByteArray imageData = file.readAll();
//                item.image = imageData;
//                file.close();// хз
//            } else {
//            item.image = query.value(1).toByteArray();
//            qDebug()<< "Изображение не пустое";
//            }
//            m_items.append(item);
//        }
//    }
//    endResetModel();
//    emit myModelCreate();
}

void MyModel::seachName(QString title,QString parametr)
{
    beginResetModel();
    m_items.clear();
    title = "Снимок экрана 2025-05-11 131944.png";
    QSqlQuery query;
    query.exec("SELECT name_recepie,photo_recepie FROM recepies Where "+parametr+" = '"+title+"'");
    while (query.next()) {
        Item item;
        item.id = query.value(0).toInt();
        item.name = query.value(1).toString();
        item.image = query.value(2).toByteArray();
        m_items.append(item);
    }
    endResetModel();

}

void MyModel::refreshModel()
{
    beginResetModel();
        m_items.clear();

        // Используем курсор для последовательной загрузки
        QSqlQuery query;
        query.setForwardOnly(true); // Важно! Экономит память
        query.prepare("SELECT id, name_recepie, photo_recepie FROM recepies");

        if (!query.exec()) {
            qCritical() << "Query failed:" << query.lastError().text();
            endResetModel();
            return;
        }

        // Загружаем данные порциями
        int count = 0;
        while (query.next() && count < 20) { // Лимит 100 записей
            Item item;
            item.id = query.value(0).toInt();
            item.name = query.value(1).toString();

            // Пропускаем NULL-изображения
            if (!query.value(2).isNull()) {
                QByteArray imgData = query.value(2).toByteArray();
                if (imgData.size() < 2*1024*1024) { // Не более 4MB
                    item.image = imgData;
                }
            }

            m_items.append(item);
            count++;

            if (count % 10 == 0) {
                QCoreApplication::processEvents();
            }
        }

        endResetModel();
}
QByteArray MyModel::getDefaultImage() const
{
    QFile file(":/assets/image/dinner.png");
    if (file.open(QIODevice::ReadOnly)) {
        return file.readAll();
    }
    return QByteArray();
}

QByteArray MyModel::getCompressedImage(const QByteArray& original) const
{
    QImage img;
    if (!img.loadFromData(original)) return getDefaultImage();

    // Сжатие до 800px по ширине
    if (img.width() > 800) {
        img = img.scaledToWidth(800, Qt::SmoothTransformation);
    }

    QBuffer buffer;
    buffer.open(QIODevice::WriteOnly);
    img.save(&buffer, "JPEG", 70); // 70% качества
    return buffer.data();
}
