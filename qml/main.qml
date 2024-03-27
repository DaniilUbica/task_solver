import QtQuick 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: root
    visible: true
    minimumWidth: QMConst.mainWindowMinWidth
    minimumHeight: QMConst.mainWindowMinHeight

    ColumnLayout {
        spacing: QMConst.largeMargin
        anchors.fill: parent

        TabBar {
            id: bar
            width: root.width

            Repeater {
                model: ["1", "2", "3", "4", "5", "6"]

                TabButton {
                    text: modelData
                    width: root.width / 6
                }
            }
        }

        StackLayout {
            id: stackLayout
            currentIndex: bar.currentIndex
            Layout.topMargin: QMConst.largeMargin
            Layout.fillHeight: true

            TaskInput {
                id: task1Input
                numInputs: 3
                inputPlaceholders: ["Число деталей", "Время", "Отказало деталей"]
                inputKeys: [inputKeysHolder.num(), inputKeysHolder.time(), inputKeysHolder.failed()]
            }

            TaskInput {
                id: task2Input
                numInputs: 6
                inputPlaceholders: ["Число деталей", "Время", "Отказало деталей", "Начало интервала", "Конец интервала", "Отказало деталей"]
                inputKeys: [inputKeysHolder.num(), inputKeysHolder.time(), inputKeysHolder.failed(),
                        inputKeysHolder.interval_start(), inputKeysHolder.interval_end(), inputKeysHolder.interval_failed()]
            }

            TaskInput {
                id: task3Input
                numInputs: 5
                inputPlaceholders: ["Число деталей", "Время", "Отказало деталей", "Доп. время", "Отказало деталей"]
                inputKeys: [inputKeysHolder.num(), inputKeysHolder.time(), inputKeysHolder.failed(),
                        inputKeysHolder.additional_time(), inputKeysHolder.additional_time_failed()]
            }

            TaskMultilineInput {
                id: task4Input
                numInputText: "Введите число деталей"
                repeaterInputText: "Время работы детали"
                inputKeys: [inputKeysHolder.num(), inputKeysHolder.detail_work_times()]
            }

            TaskMultilineInput {
                id: task5Input
                numInputText: "Введите число деталей"
                repeaterInputText: "Время работы детали"
                inputKeys: [inputKeysHolder.num(), inputKeysHolder.detail_work_times()]
            }

            TaskMultilineInput {
                id: task6Input
                numInputText: "Введите число интервалов"
                repeaterInputText: "Интервал и количество"
                inputKeys: [inputKeysHolder.num(), inputKeysHolder.details_work_interval_and_num()]
                delimiter: "_"
            }
        }

        QMButton {
            id: confirmButton

            text: "Расчитать ответ"
            height: QMConst.buttonNormalHeight
            width: QMConst.buttonNormalWidth
            Layout.alignment: Qt.AlignHCenter

            onClicked: {
                taskSolver.setInputData(stackLayout.itemAt(stackLayout.currentIndex).getInputData())
                taskSolver.solveTask(stackLayout.currentIndex + 1)
                resultText.text = "Результат расчета = " + taskSolver.resultValues
            }
        }

        Text {
            id: resultText
            font.pixelSize: QMConst.fntMainSize
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: QMConst.largeMargin
        }
    }
}
