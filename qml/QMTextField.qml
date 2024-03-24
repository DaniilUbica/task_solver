import QtQuick 2.12
import QtQuick.Controls 2.12

TextField {
    id: root
    selectByMouse: true

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        color: root.enabled ? QMConst.primaryColor : QMConst.primaryColorLight
        border.color: root.focus ? QMConst.secondaryColorBold : root.enabled ? QMConst.secondaryColor : QMConst.primaryColorLight
        border.width: root.focus ? 2 : 1
        radius: 2
    }
}
