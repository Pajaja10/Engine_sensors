import QtQuick 2.0
import QtQuick.Window 2.2

Item {
    id: id_dashboard

    //to creating data for demonstration purpose
    property int count: 0
    property int randNum: 0
    property var actValueList: []
    property bool pravyBlinkr
    property bool levyBlinkr


    Connections{
        target: pristrojeWidget
        property var actValueList
        onVstupyChanged: {
            actValueList = pristrojeWidget.vstupyValue
            id_info.fuelValue = actValueList[0] / 3.3 * 4
            id_speed.value = actValueList[1] / 3.3 * 200
            id_gear.value = Math.round(actValueList[2] / 3.3 * 5)
            pravyBlinkr = actValueList[8]
            levyBlinkr = actValueList[9]



            }

        }

    Timer {
        id: id_timer
        repeat: true
        interval: 1000
        running: true



        }


    Rectangle {
        id: id_speedArea

        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width * 0.4
        height: width
        color: "black"
        radius: width/2
        z: 1

        Speed {
            id: id_speed
            anchors.fill: id_speedArea
            anchors.margins: id_speedArea.width * 0.025
        }
    }

    Rectangle {
        id: id_gearArea

        anchors {
            bottom: id_speedArea.bottom
        }
        x: parent.width / 20
        width: parent.width * 0.35
        height: width
        color: "black"
        radius: width/2

        Gear {
            id: id_gear
            anchors.fill: id_gearArea
            anchors.margins: id_gearArea.width * 0.025
        }
    }

    Rectangle {
        id: id_infoArea

        anchors {
            bottom: id_speedArea.bottom
        }
        x: parent.width - parent.width / 2.5
        width: parent.width * 0.35
        height: width
        color: "black"
        radius: width/2

        Info {
            id: id_info
            anchors.fill: id_infoArea
            anchors.margins: id_infoArea.width * 0.025
        }
    }

    Rectangle {
        anchors {
            bottom: id_speedArea.bottom
            left: id_gearArea.horizontalCenter
            right: id_infoArea.horizontalCenter
        }
        height: id_gearArea.width / 2
        color: "black"
        z: -1
    }

    Turn {
        id: id_turnLeft

        anchors {
            right: id_gearArea.right
            rightMargin: id_gearArea.height * 0.04
            bottom: id_gearArea.bottom
            bottomMargin: id_gearArea.height * 0.01
        }
        width: id_gearArea.width / 5.5
        height: id_gearArea.height / 8.2

        isActive: levyBlinkr
    }

    Turn {
        id: id_turnRight

        anchors {
            left: id_infoArea.left
            leftMargin: id_infoArea.height * 0.04
            bottom: id_infoArea.bottom
            bottomMargin: id_infoArea.height * 0.01
        }
        width: id_infoArea.width / 5.5
        height: id_infoArea.height / 8.2
        transformOrigin: Item.Center
        rotation: 180

        isActive: pravyBlinkr
    }
}
