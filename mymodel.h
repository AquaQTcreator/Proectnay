#ifndef MYMODEL_H
#define MYMODEL_H

#include "authorizacia.h"
#include <QQuickImageProvider>
#include <QImage>
#include "imageget.h"
class MyModel:public QObject
{
    Q_OBJECT
public:
    explicit MyModel(QObject*parent = nullptr);
    Q_INVOKABLE void sendImage();
    Q_INVOKABLE void getImage();
    void setProvider(ImageGet *provider);

private:
    ImageGet *m_provider = nullptr;
};

#endif // MYMODEL_H
