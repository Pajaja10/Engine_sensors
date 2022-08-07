import QtQuick 2.0

Item {
    id: element6
    width: 640
    height: 480


    //definice proměnných
    property string cely_text: "jjj"
    property var actValueList
    property real tlakOleje
    property real tlakPaliva
    property real teplotaOleje
    property real teplotaVody
    property real stavPaliva




    Rectangle {
        id: rectangle
        color: "transparent"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Image {
            id: image
            width: 480
            height: 640
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "zada.jpeg"

            Vyskomer {
                id: vyskomer
                x: 322
                y: 228
            }
                    }


        Row {
            id: row
            x: 80
            y: 0
            width: 480
            height: 240
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0

            Vario {
                id: vario
                width: 180
                height: 180
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 30
            }

            Rychlomer {
                id: rychlomer
                width: 180
                height: 180
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 30
            }
        }

        Kompas {
            id: kompas
            x: 73
            y: 232
        }


    }

    Connections{
        id : connection
        target: pristrojeWidget





        onVstupyChanged: {
            actValueList = pristrojeWidget.vstupyValue
            rychlomer.value = actValueList[0] * 300
            vario.value = actValueList[1] * 20 - 10
            kompas.value = actValueList[0] * 360
            vyskomer.value = actValueList[0] * 10000

            //rpm.value = 200


        }

    }









}



/*##^##
Designer {
    D{i:8;anchors_width:200;anchors_x:0;anchors_y:580}
}
##^##*/
