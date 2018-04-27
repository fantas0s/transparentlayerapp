import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Click on anywhere")
    color: "black"

    Rectangle {
        id: colorChangeRectangle
        property color currentColor: Qt.rgba(1,1,1,1)
        color: currentColor
        anchors.centerIn: parent
        height: parent.height / 3
        width: parent.width / 3
        MouseArea {
            anchors.fill: parent
            onPressed: {
                colorChangeRectangle.currentColor = colorChangeRectangle.color
                var r = Math.random(1)
                var g = Math.random(1)
                var b = Math.random(1)
                colorChangeRectangle.color = Qt.rgba(r,g,b,1)
            }
            onPressAndHold: {
                colorChangeRectangle.color = colorChangeRectangle.currentColor
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        z: 1000
        onPressed: {
            touchRevealCircle.basex = mouse.x
            touchRevealCircle.basey = mouse.y

            fadeDownAnimation.duration = 0
            expandAnimation.duration = 0
            touchRevealCircle.width = 0
            touchRevealCircle.opacity = 1

            fadeDownAnimation.duration = 500
            expandAnimation.duration = 500
            touchRevealCircle.width = 20.0 * Screen.pixelDensity
            touchRevealCircle.opacity = 0
            mouse.accepted = false
        }
    }
    Rectangle {
        id: touchRevealCircle
        /* 10mm x 10mm */
        width: 20.0 * Screen.pixelDensity
        height: width
        radius: width / 2
        color: "white"
        opacity: 0.0
        property int basex: 0
        property int basey: 0
        x: basex-(width/2)
        y: basey-(width/2)

        Behavior on opacity {
            NumberAnimation {
                id: fadeDownAnimation
                duration: 0
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on width {
            NumberAnimation {
                id: expandAnimation
                duration: 0
                easing.type: Easing.InOutQuad
            }
        }
    }
}
