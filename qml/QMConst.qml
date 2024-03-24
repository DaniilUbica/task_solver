pragma Singleton

import QtQuick 2.0

QtObject {
    readonly property int mainWindowMinHeight: 350
    readonly property int mainWindowMinWidth:  800

    readonly property int smallMargin:  4
    readonly property int normalMargin: 8
    readonly property int largeMargin:    16

    readonly property int buttonNormalWidth:  100
    readonly property int buttonNormalHeight: 40

    readonly property int textFieldNormalWidth:  200
    readonly property int textFieldNormalHeight: 40

    readonly property int fntMainSize: 36

    readonly property string primaryColor:       "#f6f6f6"
    readonly property string primaryColorLight:  "#f0f0f0"
    readonly property string secondaryColor:     "#008F7A"
    readonly property string secondaryColorBold: "#006F60"
    readonly property string borderColor:        "#bdbebf"
}
