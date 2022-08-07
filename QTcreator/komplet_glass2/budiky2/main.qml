import QtQuick 2.0

Item {
    id: element6
    width: 600
    height: 1026

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
        color: "#000000"
        //anchors.rightMargin: 0
        //anchors.bottomMargin: 0
        //anchors.leftMargin: 0
        //anchors.topMargin: 0
        anchors.fill: parent
        width: parent
        height: parent

        Image {
            id: image
            //width: 480
            //height: 640
            anchors.fill: parent
            fillMode: Image.Stretch
            source: "zada.jpeg"
        }

        Text {
            id: element3
            width: parent.width //480
            height: width / 10
            color: "#ffffff"
            text: qsTr("Provozní hodnoty motoru")
            font.family: "ubuntu"
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            //anchors.topMargin: 0
            anchors.left: parent.left
            //anchors.leftMargin: 0
            //anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: width/15
        }



        Column {
            id: column
            width: parent.width //480
            height: width/2
            //anchors.topMargin: 0
            //opacity: 0.9 // pul - 2 vedle sebe
            anchors.left: parent.left
            anchors.leftMargin: 0
            //anchors.top: parent.top
            anchors.top: element3.bottom
            //anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: rpm_text
                width: parent.width / 2
                height: width/6
                color: "#ffffff"
                text: qsTr("RPM 1/min")
                font.bold: true
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                anchors.left: column.left
                anchors.top: column.top
                //anchors.leftMargin: 0
                //anchors.horizontalCenter: rpm.horizontalCenter
                font.pixelSize: width / 10

            }

            Kulaty {
                id: rpm
                width: parent.width / 2
                height: width
                anchors.left: parent.left
                //anchors.leftMargin: 0
                anchors.top: rpm_text.bottom
                //anchors.topMargin: -10
                //min a max hodnota grafu
                min_hodnota: 0
                max_hodnota: 6000
                //prubeh cerveny od 0 do min a od max do max hodnoty
                max_cervena: 5000
                // prubeh zeleny
                min_zelena: 1200
                max_zelena: 4500
            }
            Text {
                id: rpm2_text
                width: parent.width / 2
                height: width/6
                color: "#ffffff"
                text: qsTr("RPM 1/min")
                font.bold: true
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                anchors.right: column.right
                //anchors.leftMargin: 0
                //anchors.horizontalCenter: rpm.horizontalCenter
                font.pixelSize: width / 10

            }

            Kulaty {
                id: rpm2
                width: parent.width / 2
                height: width
                anchors.right: parent.right
                //anchors.leftMargin: 0
                anchors.top: rpm2_text.bottom
                //anchors.topMargin: -10
                //min a max hodnota grafu
                min_hodnota: 0
                max_hodnota: 6000
                //prubeh cerveny od 0 do min a od max do max hodnoty
                max_cervena: 5000
                // prubeh zeleny
                min_zelena: 1200
                max_zelena: 4500
            }
        }

        Row {
            id: row
            width: parent.width / 2
            height: width
            antialiasing: false
            anchors.top: column.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Text {
                id: element
                width: parent.width
                height: parent.width /6
                color: "#ffffff"
                text: qsTr("Tlak")
                font.bold: false
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                //anchors.leftMargin: 0
                //anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: width / 10
            }

            Posuvny {
                id: tlak_olej
                width: parent.width
                height: parent.width /6

                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: element.bottom
                anchors.topMargin: 0
                unit: "Olej"

                //property real hodnota_mereni
                //texty
                //min a max hodnota grafu
                min_hodnota: 0
                max_hodnota: 5
                //prubeh cerveny od 0 do min a od max do
                min_cervena: 0.5
                max_cervena: 4.5
                // prubeh zeleny
                min_zelena: 1
                max_zelena: 4

            }

            Posuvny {
                id: tlak_paliva
                height: parent.width /6
                width: parent.width
                anchors.top: tlak_olej.bottom
                //anchors.topMargin: 0
                anchors.left: parent.left
                //anchors.leftMargin: 0
                //anchors.horizontalCenter: parent.horizontalCenter
                unit: "Palivo"

                //property real hodnota_mereni
                //texty
                //min a max hodnota grafu
                min_hodnota: 0
                max_hodnota: 5
                //prubeh cerveny od 0 do min a od max do
                min_cervena: 0.5
                max_cervena: 4.5
                // prubeh zeleny
                min_zelena: 1
                max_zelena: 4
            }

            Text {
                id: element1
                height: parent.width /6
                width: parent.width
                color: "#ffffff"
                text: qsTr("Teplota")
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: tlak_paliva.bottom
                //anchors.topMargin: 0
                font.bold: false
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: width / 10
            }

            Posuvny {
                id: teplota_oleje
                width: parent.width
                height: parent.width /6
                anchors.top: element1.bottom
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                max_cervena: 130
                max_zelena: 110
                unit: "Olej"
                max_hodnota: 150
                min_zelena: 50
                min_hodnota: 0
                min_cervena: 30
            }

            Posuvny {
                id: teplota_vody
                height: parent.width /6
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: teplota_oleje.bottom
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                max_cervena: 130
                max_zelena: 110
                unit: "Voda"
                max_hodnota: 150
                min_zelena: 50
                min_hodnota: 0
                min_cervena: 30
            }


        }

        /*Column {
            id: column1
            width: 481
            height: 100
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            //anchors.top: row.bottom
            //anchors.topMargin: 0
            //anchors.horizontalCenter: parent.horizontalCenter


            Text {
                id: element4
                width: 105
                color: "#ffffff"
                text: qsTr("Baterie")
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 25
            }

            Text {
                id: element5
                color: "#ffffff"
                text: qsTr("14.15 V")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 25
            }
        }
*/
        Row {
            id: row1
            anchors.right: parent.right
            //anchors.rightMargin: 0
            anchors.bottom: row.bottom
            //anchors.bottomMargin: 0
            anchors.top: row.top
            //anchors.topMargin: 0
            anchors.left: row.right
            //anchors.leftMargin: 0

            Palivo {
                id: stav_paliva
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                max_hodnota: 80
                rezerva: 20

            }
        }
    }


    Connections{
        id : connection
        target: pristrojeWidget





        onVstupyChanged: {
            actValueList = pristrojeWidget.vstupyValue
            tlak_olej.value = actValueList[5] * 5
            tlak_paliva.value = actValueList[1] * 5
            teplota_oleje.value = actValueList[2] * 150
            teplota_vody.value = actValueList[3] * 150
            stav_paliva.value = actValueList[4] * 80
            rpm.value = actValueList[2] * 6
            //rpm.value = 200


        }

    }





    Rectangle {
        id: rectangle1
        height: 60
        color: "#ff0808"
        visible: false
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
            text: "aaa"//tvorbaTextu()
            font.bold: true
            anchors.fill: parent
            visible: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }
    }

    function tvorbaTextu()
    {   cely_text = ""
        if (rpm.value>rpm.max_cervena)
            cely_text += "!!POZOR dosaženy maximální otáčky!!\n"
        if (tlak_olej.value>tlak_olej.max_cervena)
            cely_text += "!!POZOR tlak oleje!!\n"
        if (tlak_paliva.value>tlak_paliva.max_cervena)
            cely_text += "!!POZOR tlak paliva!!\n"
        if (teplota_vody.value>teplota_vody.max_cervena)
            cely_text += "!!POZOR teplota vody!!\n"
        if (teplota_oleje.value>teplota_oleje.max_cervena)
            cely_text += "!!POZOR teplota oleje!!\n"
        if (stav_paliva.value<stav_paliva.rezerva)
            cely_text += "!!POZOR letíš na rezervu!!\n"
        if (cely_text || "")
            rectangle1.visible = true
        else rectangle1.visible = false

        return cely_text
    }


}



/*##^##
Designer {
    D{i:13;anchors_x:0;anchors_y:580}D{i:17;anchors_x:173;anchors_y:27}D{i:20;anchors_width:200}
}
##^##*/



/*##^## Designer {
    D{i:2;invisible:true}
}
 ##^##*/
