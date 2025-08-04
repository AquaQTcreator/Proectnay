#include "profildata.h"

ProfilData::ProfilData(QObject*parent):QObject(parent)
{

}

QString ProfilData::openFileDialog()
{
    QString filter = "Изображения (*.jpg *.jpeg *.png)";
    QString fileName = QFileDialog::getOpenFileName(nullptr,"Выберите файл","D;/",filter);
    return fileName;
}
