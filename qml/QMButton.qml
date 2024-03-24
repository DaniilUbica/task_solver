import QtQuick 2.0
import QtQuick.Controls 2.12

Button {
    id: root

    background: Rectangle {
        implicitWidth: QMConst.buttonNormalWidth
        implicitHeight: QMConst.buttonNormalHeight
        color: root.hovered ? QMConst.primaryColorLight : QMConst.primaryColor
        border.color: QMConst.borderColor
        border.width: 1
        radius: 2
    }
}
