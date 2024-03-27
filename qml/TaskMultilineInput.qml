import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    property int rows:                 1
    property int columns:              0
    property int detailsNum:           0
    property string numInputText:      ""
    property string repeaterInputText: ""
    property string delimiter:         "-"
    property var inputKeys:            []

    readonly property int maxColumnsNum: 4
    readonly property int maxRowsNum:    2

    ScrollView {
        clip: true
        anchors.fill: parent
        contentHeight: detailsNumInput.height + grid.height + linesInput.height + QMConst.normalMargin * 3
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        Item {}

        ColumnLayout {
            id: column
            spacing: QMConst.normalMargin

            QMTextField {
                id: detailsNumInput
                placeholderText: numInputText

                onTextChanged: {
                    root.detailsNum = detailsNumInput.text !== "" ? parseInt(detailsNumInput.text) : 0
                    root.columns = root.detailsNum > root.maxColumnsNum ? root.maxColumnsNum : root.detailsNum

                    var tmp = root.detailsNum
                    while (tmp > root.maxColumnsNum) {
                        root.rows++
                        tmp /= 2
                    }

                    setPlaceholdersNums()
                }
            }

            GridLayout {
                id: grid
                columns: root.columns
                rowSpacing: QMConst.normalMargin
                columnSpacing: QMConst.normalMargin

                Repeater {
                    id: linesInput
                    model: root.detailsNum

                    QMTextField {
                        placeholderText: repeaterInputText
                        width: (grid.width - (grid.columns - 1) * grid.columnSpacing) / grid.columns - QMConst.normalMargin * 4
                    }
                }

                onVisibleChanged: {
                    if (!visible) {
                        root.rows = 0
                    }
                }
            }
        }
    }

    function setPlaceholdersNums() {
        for (let i = 0; i < detailsNum; i++) {
            linesInput.itemAt(i).placeholderText += " " + (i + 1)
        }
    }

    function getInputData() {
        let str = inputKeys[0] + ":" + detailsNumInput.text + " " + inputKeys[1] + ":"
        for (let i = 0; i < detailsNum; i++) {
            str += linesInput.itemAt(i).text + root.delimiter
        }
        console.log(str)
        return str
    }
}
