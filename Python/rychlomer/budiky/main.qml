import QtQuick 2.0

Item {
    id: element6
    width: 480
    height: 640

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
        color: "#ffffff"
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

        }

        Column {
            id: column
            width: 480
            height: 216
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter



        }

        Row {
            id: row
            width: 320
            height: 269
            antialiasing: false
            anchors.top: column.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0







        }

        Column {
            id: column1
            width: 480
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: row.bottom
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter

        }

        Row {
            id: row1
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: row.bottom
            anchors.bottomMargin: 0
            anchors.top: row.top
            anchors.topMargin: 0
            anchors.left: row.right
            anchors.leftMargin: 0


        }

        Rychlomer {
            id: rychlomer
            x: 53
            y: 127
        }
    }

    Connections{
        id : connection
        target: pristrojeWidget





        onVstupyChanged: {
            actValueList = pristrojeWidget.vstupyValue
            rychlomer.value = actValueList[0] * 300

            //rpm.value = 200


        }

    }





    Rectangle {
        id: rectangle1
        height: 60
        color: "#ff0808"
        z: -70.109
        border.color: "#ff0808"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0


        Text {
            id: element7
            color: "#ffffff"
            //text: tvorbaTextu()
            font.bold: true
            anchors.fill: parent
            visible: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20






        }

    }



}



/*##^##
Designer {
    D{i:5;anchors_x:0;anchors_y:580}D{i:9;anchors_width:200}
}
##^##*/
