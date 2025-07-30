#ifndef IMAGEGET_H
#define IMAGEGET_H

#include <QQuickImageProvider>
#include <QImage>

class ImageGet : public QQuickImageProvider
{
public:
    ImageGet();
    void setImage(const QImage &img);
        QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

    private:
        QImage m_image;
};

#endif // IMAGEGET_H
