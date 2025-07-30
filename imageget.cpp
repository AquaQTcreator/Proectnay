#include "imageget.h"

ImageGet::ImageGet(): QQuickImageProvider(QQuickImageProvider::Image)
{

}
void ImageGet::setImage(const QImage &img) {
    m_image = img;
}
QImage ImageGet::requestImage(const QString &, QSize *size, const QSize &) {
    if (size)
        *size = m_image.size();
    return m_image;
}
