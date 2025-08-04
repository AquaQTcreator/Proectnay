#include "signup.h"

SignUp::SignUp(QObject*parent):QObject(parent)
{

}

void SignUp::getDataForSignUp(QString name, QString lastname, QString login, QString password)
{   int numbers = 0;
    int smallSymbol = 0;
    int bigSmall = 0;
    int otherSymbol = 0;
    QString status = "";
    QSqlQuery query;
    if(name !="" && lastname != "" && login != "" && password != "") { //Проверка на пустоту и длину
        for (int i = 0; i < password.length(); ++i) {  //Цикл где разибваем на символы и проверяем слова на количество букв и цифр
            QChar symbol = password.at(i);
            int code = symbol.toLatin1();
            if(48 <= code &&  code  <= 57) numbers++;
            else if (97 <= code &&  code  <= 122) smallSymbol++;
            else if (65 <= code &&  code  <= 90) bigSmall++;
            else otherSymbol++;
        }
        qDebug()<<numbers<<smallSymbol<<bigSmall;
        if (numbers >= 3 && smallSymbol >= 3 && bigSmall >= 3 && password.length() < 12 && otherSymbol == 0) { //Проверка количества символов и цифр
            query.prepare("SELECT EXISTS (SELECT 1 FROM users WHERE email = '"+dataToHash(login)+"' AND password = '"+dataToHash(password)+"')");
            if (query.exec() && query.next()) {
                if (!query.value(0).toBool()) {
                    query.prepare("INSERT INTO users (first_name,last_name,email,password) VALUES ('"+name+"',"
                     " '"+lastname+"','"+dataToHash(login)+"','"+dataToHash(password)+"');");
                    if (!query.exec()) {
                        status = "Ошибка регистрации";
                    } else {
                        status = "Вы зарегестрированы!";
                    }
                }
                else { status = "Такие данные есть"; }
            }
        }
        else if (otherSymbol != 0) status = "В пароле разрешены только цифры и латинские буквы";
        else { status = "Количество символов цифр ,заглавных букв ,букв каждым минимум 3 "; }
    }
    else { status = "Пусто в строчках"; }
    if (password.length() >=12) status = "Количество всех символов должно быть меньше 12 ";
    emit statusSignUp(status);
    dataToHash(name);
    //     QSqlQuery query;
    //     if(query.exec("SELECT*FROM users")) {
    //         while (query.next()) {
    //         QString str = query.value("first_name").toString();
    //         qDebug()<<str;
    //         }
    //     }
    //     else qDebug()<<"error query";
}

QString SignUp::dataToHash(QString dataToHash)
{
    int code = 0;
    QString finalHash;
    for (int i = 0; i < dataToHash.length(); ++i) {  //Цикл где разибваем на символы и проверяем слова на количество букв и цифр
        QChar symbol = dataToHash.at(i);
        code = symbol.toLatin1();
        finalHash += QString::number(code*i);
    }
    return  finalHash;
}
