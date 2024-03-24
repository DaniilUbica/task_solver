import QtQuick 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Item {
    id: root

    property int numInputs: 1
    property var inputPlaceholders: []
    property var inputKeys: []

    Component.onCompleted: {
        setPlaceholders()
    }

    RowLayout {
        id: layout
        spacing: QMConst.normalMargin
        width: parent.width

        Repeater {
            id: compInput
            model: numInputs

            QMTextField {
                id: textField
                implicitHeight: QMConst.textFieldNormalHeight
                implicitWidth: layout.width / numInputs - layout.spacing * (numInputs - 1)
            }
        }
    }

    function setPlaceholders() {
        for (let i = 0; i < numInputs; i++) {
            compInput.itemAt(i).placeholderText = inputPlaceholders[i]
        }
    }

    function getInputData() {
        let str = ""
        for (let i = 0; i < numInputs; i++) {
            str += inputKeys[i] + ':' + compInput.itemAt(i).text + ' '
        }

        return str
    }
}
