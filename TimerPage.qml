import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
Item {
    id:pageTimer
    width: 428
    height: 926

    property int initialTime: 0
    property int initialMinute: 0// Стартовое время (секунды)
    property int initialHour: 0

    property int hour: initialHour
    property  int minute: initialMinute
    property int remainingTime: initialTime
    property bool isRunning: false
    Component.onCompleted: {
        hourTimer.clear()
        minTimer.clear()
        textTimer.clear()
    }

    function stopTimer() {
        isRunning = false
    }

    function resetTimer() {
        stopTimer()
        hour = 0
        minute = 0
        remainingTime = 0

        hourTimer.text = "00"
        minTimer.text = "00"
        textTimer.text = "00"
    }
    function resetVauleTimer() {
        stopTimer()
        hour = initialHour
        minute = initialMinute
        remainingTime = initialTime

        hourTimer.text = hour.toString()
        minTimer.text = minute.toString()
        textTimer.text = remainingTime.toString()

    }
    Rectangle {
        anchors.fill: parent
        width: parent.width
        height: parent.height
        color:Qt.rgba(248/255,232/255,233/255,1)
        // Таймер
        Timer {
            id: countdownTimer
            interval: 1000
            repeat: true
            running: isRunning
            onTriggered: {
                if (remainingTime > 0) {
                    remainingTime--
                } else if (minute > 0) {
                    minute--
                    remainingTime = 59
                } else if (hour > 0) {
                    hour--
                    minute = 59
                    remainingTime = 59
                } else {
                    stopTimer()
                }
                hourTimer.text = hour.toString()
                minTimer.text = minute.toString()
                textTimer.text = remainingTime.toString()
            }
        }




        Rectangle {
            x:20
            y:123
            width: 386
            height: 110
            color: "white"
            Row {
                anchors.centerIn: parent
                width: parent.width
                spacing: 10
                TextField {
                    width: 100
                    height: 84
                    id:hourTimer
                    text:hour.toString()
                    onPressed: { // Останавливаем таймер
                        isRunning = false;
                        clear()
                    }
                    onEditingFinished: {
                        hour = Math.min(parseInt(text) || 0, 99)
                        text = hour.toString()
                        initialHour = hour // Обновляем начальное значение  // Ограничение до 99 // Ограничение задаем в validator
                    }
                    background: Rectangle {
                        anchors.fill: parent
                        color: "white"
                    }

                    font {
                        pixelSize: 64
                        bold: true
                        family: "Inter"
                    }
                    validator: IntValidator { bottom: 0; top: 99 } //tut
                    placeholderText: "00"
                    placeholderTextColor: "black"
                }
                Label {
                    text: ":"
                    font {
                        pixelSize: 64
                        bold: true
                        family: "Inter"
                    }
                }

                TextField {
                    id: minTimer
                    width: 100
                    height: 84
                    text: minute.toString()
                    font { pixelSize: 64; bold: true; family: "Inter" }

                    onPressed: {
                        isRunning = false;
                        clear()
                    }

                    onEditingFinished: {
                        minute = Math.min(parseInt(text) || 0, 59)
                        text = minute.toString()
                        initialMinute = minute
                    }
                    background: Rectangle {
                        anchors.fill: parent
                        color: "white"
                    }

                    validator: IntValidator { bottom: 0; top:99 }
                    placeholderText: "00"
                    placeholderTextColor: "black"
                }
                Label {
                    text: ":"
                    font {
                        pixelSize: 64
                        bold: true
                        family: "Inter"
                    }
                }
                TextField {
                    id: textTimer
                    width: 100
                    height: 84
                    text:remainingTime.toString()
                    font { pixelSize: 64; bold: true; family: "Inter" }

                    onPressed: {
                        isRunning = false;
                        clear()
                    }

                    onEditingFinished: {
                        remainingTime = Math.min(parseInt(text) || 0, 59)
                        text = remainingTime.toString()
                        initialTime = remainingTime  // Ограничение до 59 секунд
                    }
                    background: Rectangle {
                        anchors.fill: parent
                        color: "white"
                    }

                    validator: IntValidator { bottom: 0; top: 99 }
                    placeholderText: "00"
                    placeholderTextColor: "black"
                }
            }
        }

        // Интерфейс
        Column {
            x:60
            y:374
            width:259
            height: 560
            spacing: 20
            Button {
                id:startStopButton
                width: 259
                height: 72
                text: isRunning ? "Стоп" : "Старт"

                background: Rectangle {
                    id: buttonBg
                    anchors.fill: parent
                    radius: 8
                    opacity: startStopButton.pressed ? 0.5 : 1
                    color: isRunning ?  Qt.rgba(218/255,229/255,225/255,1) : Qt.rgba(148/255,201/255,169/255,1)

                }
                onClicked: {
                    if(remainingTime > 0 || hour > 0 || minute > 0) {
                        isRunning = !isRunning
                    }
                }

            }

            Button {
                id:butReset
                width: 259
                height: 72
                text: "Сброс"
                onClicked: resetTimer()
                background: Rectangle {
                    radius: 8
                    color: Qt.rgba(201/255,55/255,86/255,1)
                    opacity: butReset.pressed ? 0.5 : 1

                }
            }
            Button {
                id:butResetValue
                width: 259
                height: 72
                text: "Рестарт"
                onClicked: resetVauleTimer()
                background: Rectangle {
                    radius: 8
                    color: Qt.rgba(148/255,155/255,201/255,1)
                    opacity: butResetValue.pressed ? 0.5 : 1
                }
            }
        }

        Image {
            id:butBack
            x:11
            y:755
            width: 75
            height: 75
            source: "qrc:/assets/image/ButBack.png"
            MouseArea {
                anchors.fill: parent
                onClicked: stackPage.pop()
            }
        }

        NavigatePanel {
            anchors.bottom: parent.bottom
        }
    }
}
