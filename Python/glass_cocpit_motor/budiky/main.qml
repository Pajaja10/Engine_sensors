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

            Text {
                id: element2
                height: 45
                color: "#ffffff"
                text: qsTr("Otáčky")
                font.bold: true
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                anchors.left: rpm.left
                anchors.leftMargin: 0
                anchors.horizontalCenter: rpm.horizontalCenter
                font.pixelSize: 32

            }

            Kulaty {
                id: rpm
                width: 216
                height: 216
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: element2.bottom
                anchors.topMargin: -10
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
            width: 320
            height: 269
            antialiasing: false
            anchors.top: column.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Text {
                id: element
                height: 50
                color: "#ffffff"
                text: qsTr("Tlak")
                font.bold: false
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32
            }

            Posuvny {
                id: tlak_olej
                width: 320
                height: 40

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
                anchors.top: tlak_olej.bottom
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
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
                height: 50
                color: "#ffffff"
                text: qsTr("Teplota")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: tlak_paliva.bottom
                anchors.topMargin: 0
                font.bold: false
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 32
            }

            Posuvny {
                id: teplota_oleje
                width: 320
                height: 40
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
                height: 40
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
                id: teplota_vzduchu
                color: "#ffffff"
                //text: qsTr("14.15 V")
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.left: element4.left
                anchors.leftMargin: 0
                anchors.top: element4.bottom
                anchors.topMargin: 0
                anchors.horizontalCenter: element4.horizontalCenter
                font.pixelSize: 25
            }
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

            Palivo {
                id: stav_paliva
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                max_hodnota: 80
                rezerva: 20

            }
        }

        Text {
            id: element3
            width: 480
            height: 44
            color: "#ffffff"
            text: qsTr("Provozní hodnoty motoru")
            font.family: "ubuntu"
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 36
        }
    }

    Connections{
        id : connection
        target: pristrojeWidget





        onVstupyChanged: {
            actValueList = pristrojeWidget.vstupyValue
            tlak_olej.value = actValueList[1] * 5 / 256
            tlak_paliva.value = actValueList[2] * 5 / 256
            teplota_oleje.value = actValueList[6] * 150 / 256
            teplota_vody.value = actValueList[4] * 150 / 256
            stav_paliva.value = actValueList[5] * 80 / 256
            teplota_vzduchu.text = Math.round(((actValueList[3] / 256 * 5000 - 500)/ 10) * 10) / 10
            rpm.value = actValueList[0] / 256 * 6000
            //rpm.value = 200


        }

    }

    function tvorbaTextu()
    {   cely_text = ""
        element7.visible = false
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
            element7.visible = true


        return cely_text
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
                text: tvorbaTextu()
                font.bold: true
                anchors.fill: parent
                //visible: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20






    }

    }



}



/*##^##
Designer {
    D{i:13;anchors_x:0;anchors_y:580}D{i:17;anchors_x:173;anchors_y:27}D{i:20;anchors_width:200}
}
##^##*/
