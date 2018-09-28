// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0
import "common"
import "pages"
import "popups"
import "tabs"
import "navigation"

// This app demonstrates HowTo use Qt 5.8 and Qt Quick Controls 2.1, High DPI and more
// This app is NOT a production ready app
// This app's goal is only to help you to understand some concepts
// see blog http://j.mp/qt-x to learn about Qt 5.8 for Material - styled Android or iOS Apps
// learn about this bottom_nav_x app from this article: http://bit.ly/qt-bottom-nav-x
// ekke (Ekkehard gentz) @ekkescorner

ApplicationWindow {
    id: appWindow
    // visibile must set to true - default is false
    visible: true
    //
    property bool isLandscape: width > height

    // primary and accent properties:
    property variant primaryPalette: myApp.defaultPrimaryPalette()
    property color primaryLightColor: primaryPalette[0]
    property color primaryColor: primaryPalette[1]
    property color primaryDarkColor: primaryPalette[2]
    property color textOnPrimaryLight: primaryPalette[3]
    property color textOnPrimary: primaryPalette[4]
    property color textOnPrimaryDark: primaryPalette[5]
    property string iconOnPrimaryLightFolder: primaryPalette[6]
    property string iconOnPrimaryFolder: primaryPalette[7]
    property string iconOnPrimaryDarkFolder: primaryPalette[8]
    property variant accentPalette: myApp.defaultAccentPalette()
    property color accentColor: accentPalette[0]
    property color textOnAccent: accentPalette[1]
    property string iconOnAccentFolder: accentPalette[2]
    Material.primary: primaryColor
    Material.accent: accentColor
    // theme Dark vs Light properties:
    property variant themePalette: myApp.defaultThemePalette()
    property color dividerColor: themePalette[0]
    property color cardAndDialogBackground: themePalette[1]
    property real primaryTextOpacity: themePalette[2]
    property real secondaryTextOpacity: themePalette[3]
    property real dividerOpacity: themePalette[4]
    property real iconActiveOpacity: themePalette[5]
    property real iconInactiveOpacity: themePalette[6]
    property string iconFolder: themePalette[7]
    property int isDarkTheme: themePalette[8]
    property color flatButtonTextColor: themePalette[9]
    property color popupTextColor: themePalette[10]
    property real toolBarActiveOpacity: themePalette[11]
    property real toolBarInactiveOpacity: themePalette[12]
    property color toastColor: themePalette[13]
    property real toastOpacity: themePalette[14]
    // Material.dropShadowColor  OK for Light, but too dark for dark theme
    property color dropShadow: isDarkTheme? "#E4E4E4" : Material.dropShadowColor
    onIsDarkThemeChanged: {
        if(isDarkTheme == 1) {
            Material.theme = Material.Dark
        } else {
            Material.theme = Material.Light
        }
    }
    // font sizes - defaults from Google Material Design Guide
    property int fontSizeDisplay4: 112
    property int fontSizeDisplay3: 56
    property int fontSizeDisplay2: 45
    property int fontSizeDisplay1: 34
    property int fontSizeHeadline: 24
    property int fontSizeTitle: 20
    property int fontSizeSubheading: 16
    property int fontSizeBodyAndButton: 14 // is Default
    property int fontSizeCaption: 12
    property int fontSizeActiveNavigationButton: 14
    property int fontSizeInactiveNavigationButton: 12
    // fonts are grouped into primary and secondary with different Opacity
    // to make it easier to get the right property,
    // here's the opacity per size:
    property real opacityDisplay4: secondaryTextOpacity
    property real opacityDisplay3: secondaryTextOpacity
    property real opacityDisplay2: secondaryTextOpacity
    property real opacityDisplay1: secondaryTextOpacity
    property real opacityHeadline: primaryTextOpacity
    property real opacityTitle: primaryTextOpacity
    property real opacitySubheading: primaryTextOpacity
    // body can be both: primary or secondary text
    property real opacityBodyAndButton: primaryTextOpacity
    property real opacityBodySecondary: secondaryTextOpacity
    property real opacityCaption: secondaryTextOpacity
    //

    // NAVIGATION BAR PROPRTIES
    property var navigationModel: [{"name": "Mantra", "icon": "car.png", "source": "../pages/PageOne.qml"},
        {"name": "Check", "icon": "bus.png", "source": "../pages/PageTwo.qml"},
        {"name": "SignUp", "icon": "subway.png", "source": "../pages/PageThree.qml"}
/*        {"name": "Truck", "icon": "truck.png", "source": "../pages/PageFour.qml"},
        {"name": "Flight", "icon": "flight.png", "source": "../pages/PageFive.qml"}*/]
    property int navigationIndex: 0
    onNavigationIndexChanged: {
        rootPane.activeDestination(navigationIndex)
    }
    // recommended: suppress if more then 3 buttons, perhaps only on Android
    property bool suppressInactiveLabels: navigationModel.length > 3
    property bool hideTitleBar: false
    onHideTitleBarChanged: {
        if(isLandscape) {
            sideBar.active = false
            sideBar.active = isLandscape
        }
    }
    property bool navigationBarIsColored: true

    // header only used in PORTRAIT to provide a fixed TitleBar
    header: isLandscape || hideTitleBar ? null : titleBar

    footer: isLandscape? null : bottomBar

    Loader {
        id: bottomBar
        visible: !isLandscape
        active: !isLandscape
        source: navigationBarIsColored? "navigation/BottomNavigationBar.qml" : "navigation/BottomNavigationBarUncolored.qml"
    }
    Loader {
        id: sideBar
        visible: isLandscape
        active: isLandscape
        source: navigationBarIsColored? "navigation/SideNavigationBar.qml" : "navigation/SideNavigationBarUncolored.qml"
    }

    Loader {
        id: titleBar
        visible: !isLandscape && !hideTitleBar
        active: !isLandscape && !hideTitleBar
        source: "common/SimpleTextTitle.qml"
        onLoaded: {
            if(item) {
                item.text = qsTr("Mantra App")
            }
        }
    }
    // in LANDSCAPE header is null and we have a floating TitleBar
    // hint: TitleBar shadow not visible in Landscape
    // reason: TabBar must be defined inside ToolBar
    // but they're defined in column layout - haven't redesigned for this example
    // only wanted to demonstrate HowTo use fix and floating Titles
    Loader {
        id: titleBarFloating
        visible: isLandscape && !hideTitleBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: sideBar.width+6
        anchors.right: parent.right
        active: isLandscape && !hideTitleBar
        source: "common/SimpleTextTitle.qml"
        onLoaded: {
            if(item) {
                item.text = qsTr("Mantra App")
            }
        }
    }

//    FloatingActionButton {
//        id: fab
//        // will become visible as soon as first Destination loaded
//        visible: false
//        property string imageName: "/settings.png"
//        z: 1
//        anchors.margins: 16
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        imageSource: "qrc:/images/"+iconOnAccentFolder+imageName
//        backgroundColor: accentColor
//        onClicked: {
//            showSettings()
//        }
//    } // FAB

    StackView {
        id: rootPane
        focus: true
        anchors.top: isLandscape && !hideTitleBar? titleBarFloating.bottom : parent.top
        anchors.left: isLandscape? sideBar.right : parent.left
        anchors.topMargin: isLandscape && !hideTitleBar? 6 : 0
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        // shows a Busy indicator - won't be visible yet
        // but in real life loading first Page or Pane could took some time
        initialItem: InitialItemPage{}

        replaceEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 300
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 300
            }
        }

        // support of BACK key
        property bool firstPageInfoRead: false
        Keys.onBackPressed: {
            event.accepted = !firstPageInfoRead
            // user gets Popupo Info
            // hitting again BACK will close the app
            if(!firstPageInfoRead) {
                firstPageInfoRead = true
                showInfo(qsTr("Next time hitting BACK will close the app"))
                return
            }
            // We must cleanup loaded Pages

        }



        Repeater {
            id: destinations
            model: navigationModel
            // Destination encapsulates Loader
            // in next app we'll add some policies
            // to Destination HowTo load dynamically
            Destination {
                id: destinationLoader
            }
            Component.onCompleted: {
                // all destinations created
                // load the first one
                // from onLoaded will replace BusyIndicator
                destinations.itemAt(0).active = true
            }
        }
        function firstDestinationLoaded() {
            fab.visible = true
        }

        function activeDestination(navigationIndex) {
            if(destinations.itemAt(navigationIndex).status == Loader.Ready) {
                rootPane.replace(destinations.itemAt(navigationIndex).item)
            } else {
                destinations.itemAt(navigationIndex).active = true
            }
        }

    } // rootPane



    function switchPrimaryPalette(paletteIndex) {
        primaryPalette = myApp.primaryPalette(paletteIndex)
    }
    function switchAccentPalette(paletteIndex) {
        accentPalette = myApp.accentPalette(paletteIndex)
    }

    // we can loose the focus if Menu or Popup is opened
    function resetFocus() {
        rootPane.focus = true
    }

    //
    PopupPalette {
        id: popup
        onAboutToHide: {
            resetFocus()
        }
    }

    function showInfo(info) {
        popupInfo.text = info
        popupInfo.buttonText = qsTr("OK")
        popupInfo.open()
    }
    function showSettings() {
        popupSettings.open()
    }

    PopupInfo {
        id: popupInfo
        onAboutToHide: {
            popupInfo.stopTimer()
            resetFocus()
        }
    } // popupInfo

    // PopupSettings
    PopupSettings {
        id: popupSettings
        onAboutToHide: {
            if(popupSettings.update()) {
                popupToast.start(qsTr("Settings modified"))
            } else {
                resetFocus()
            }
        }
    } // popupSettings

    // PopupToast
    PopupToast {
        id: popupToast
        onAboutToHide: {
            resetFocus()
        }
    }

} // app window
