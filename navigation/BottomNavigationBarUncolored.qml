// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "../common"

Pane {
    id: myBar
    Material.elevation: 8
    z: 1
    property real activeOpacity: iconFolder == "black" ?  0.87 : 1.0
    property real inactiveOpacity: iconFolder == "black" ? 0.26 : 0.56
    leftPadding: 0
    rightPadding: 0
    height: 56
    RowLayout {
        focus: false
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 0
        Repeater {
            model: navigationModel
            NavigationButton {
                id: myButton
                isColored: true
            }
        } // repeater
    } // RowLayout
} // bottomNavigationBar
