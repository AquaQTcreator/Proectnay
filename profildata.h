#ifndef PROFILDATA_H
#define PROFILDATA_H

#include <QObject>
#include <QFileDialog>
class ProfilData:public QObject
{
    Q_OBJECT
public:
    explicit ProfilData(QObject*parent = nullptr);
    Q_INVOKABLE QString openFileDialog();
};

#endif // PROFILDATA_H
