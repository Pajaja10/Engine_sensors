import QtQuick 2.0

Item {
    id: id_root
    width: 100
    height: 280

    property alias unit : id_text_mereni.text
    property real value : 0
    //min a max hodnota grafu
    property real max_hodnota: 20
    //prubeh cerveny od 0 do min
    property real rezerva: 19
    // prubeh zeleny
    property real hodnota_mereni: Math.round(value*100)/100
    property real hodnota_posuvniku: vypocet_posuvniku()
    property color barva_pozadi: "transparent"
    property color barvaBaru: "#4cff22"



        function vypocet_posuvniku()
            {
            //zelená
            if (hodnota_mereni>rezerva && hodnota_mereni<=max_hodnota)
                {barvaBaru = "#4cff22"
                barva_pozadi = "transparent"
                return  200/max_hodnota*hodnota_mereni}
             // pro rezervu
             if (hodnota_mereni>=0 && hodnota_mereni<=rezerva)
                {barvaBaru = "#ea0909"
                 barva_pozadi = "#ea0909"
                return  200/max_hodnota*hodnota_mereni}
             //kdyz je vsechno blbe
              if (hodnota_mereni<0 || hodnota_mereni>max_hodnota)
                 { barvaBaru = "#f00000"
                  return  10}
                        }



        Rectangle {
            id: rectangle1
            color: barva_pozadi
            z: -44.022
            anchors.fill: parent
        }

    Rectangle {
        id: rectangle
        x: 32
        y: 86
        width: 50
        height: 204
        color: "#626262"
        border.width: 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: rectangle2
            x: 29
            y: 68
            width: 46
            height: hodnota_posuvniku
            color: barvaBaru
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Text {
        id: id_text_mereni
        x: 38
        y: 14
        color: "#ffffff"
        text: qsTr("Palivo")
        font.bold: true
        anchors.bottom: rectangle.top
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 30
    }

    Text {
        id: id_hodnota_mereni
        x: 38
        width: 100
        height: 40
        color: "#ffffff"
        text: hodnota_mereni
        anchors.top: rectangle.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 25
    }


}

/*##^##
Designer {
    D{i:0;height:280;width:100}D{i:1;anchors_height:200;anchors_width:200}D{i:5;anchors_height:50;anchors_x:38;anchors_y:257}
}
##^##*/
