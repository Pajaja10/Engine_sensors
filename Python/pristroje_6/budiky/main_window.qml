import QtQuick 2.0

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
            id_fuel.value = actValueList[0] / 3.3 * 4
            id_speed.value = actValueList[1] / 3.3 * 200
            id_fuel1.value = actValueList[2] / 3.3 * 4
            id_speed1.value = actValueList[3] / 3.3 * 200
            id_speed2.value = actValueList[4] / 3.3 * 200
            pravyBlinkr = actValueList[8]
            levyBlinkr = actValueList[9]



            }

        }


    Grid {
        id: grid
        spacing: 2
        rows: 2
        columns: 3
        anchors.fill: parent

        Rectangle {
            id: rectangle
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 1
            visible: true
            radius: 100

            Speed {
                id: id_speed
                visible: true
                anchors.fill: parent
            }
          }
        Rectangle {
            id: rectangle1
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 1
            visible: true
            radius: 100

            Speed1 {
                id: id_speed1
                visible: true
                anchors.fill: parent
            }
          }
        Rectangle {
            id: rectangle2
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 1
            visible: true
            radius: 100

            Fuel {
                id: id_fuel
                visible: true
                anchors.fill: parent
            }
          }
        Rectangle {
            id: rectangle3
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 1
            visible: true
            radius: 100

            Fuel1 {
                id: id_fuel1
                visible: true
                anchors.fill: parent
            }
          }
        Rectangle {
            id: rectangle4
            width: 200
            height: 200
            color: "#ffffff"
            opacity: 1
            visible: true
            radius: 100

            Speed2 {
                id: id_speed2
                visible: true
                anchors.fill: parent
            }
        }

        Row {
            id: row
            width: 200
            height: 200
            transformOrigin: Item.TopLeft
            layoutDirection: Qt.RightToLeft
            spacing: 2

            Rectangle {
                id: rectangle5
                width: 200
                height: 200
                color: "#ffffff"
                anchors.fill: parent
            }

              Rectangle {
                  id: rectangle6
                  width: 200
                  height: 200
                  color: "#ffffff"
                  anchors.fill: parent

                  Turn {
                      id: turn
                      height: 100
                      anchors.right: parent.right
                      anchors.rightMargin: 0
                      anchors.left: parent.left
                      anchors.leftMargin: 0
                      isActive: pravyBlinkr

                      anchors.top: parent.top
                      anchors.topMargin: 0
                      visible: true
                  }
                  Turn {
                      id: turn2
                      height: 100
                      anchors.right: parent.right
                      anchors.rightMargin: 0
                      anchors.left: parent.left
                      anchors.leftMargin: 0
                      anchors.bottom: parent.bottom
                      anchors.bottomMargin: 0
                      rotation: 180
                      isActive: levyBlinkr
                      visible: true
                  }
              }
          }
    }

}





/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:400;anchors_width:400;anchors_x:324;anchors_y:174}
}
 ##^##*/
