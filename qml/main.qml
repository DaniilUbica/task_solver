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
            width: root.width
            height: QMConst.textFieldNormalHeight + QMConst.normalMargin
            currentIndex: bar.currentIndex
            Layout.topMargin: QMConst.largeMargin

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
