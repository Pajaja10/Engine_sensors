import QtQuick 2.0

Item {
    id: id_root
    width: 320
    height: 40
    property alias unit : id_text_mereni.text
    property real value : 0
    //min a max hodnota grafu
    property real min_hodnota: 0
    property real max_hodnota: 20
    //prubeh cerveny od 0 do min a od max do
    property real min_cervena: 1
    property real max_cervena: 19
    // prubeh zeleny
    property real min_zelena: 3
    property real max_zelena: 17
    property real hodnota_mereni: Math.round(value*100)/100
    property real hodnota_posuvniku: vypocet_posuvniku()
    property color barva_pozadi: "transparent"
    property color barva_textu: barva_cisla()



        function vypocet_posuvniku()
            {
            if (hodnota_mereni>=min_hodnota && hodnota_mereni<=min_cervena)
                {return  -5+15/(min_cervena-min_hodnota)*(hodnota_mereni-min_hodnota)}
             // pro prvni zlutou
             if (hodnota_mereni>min_cervena && hodnota_mereni<=min_zelena)
                {return  -5+15+15/(min_zelena-min_cervena)*(hodnota_mereni-min_cervena)}
             // pro zelenou
             if (hodnota_mereni>min_zelena && hodnota_mereni<=max_zelena)
                {return  -5+30+100/(max_zelena-min_zelena)*(hodnota_mereni-min_zelena)}
             // pro druhou zlutou
             if (hodnota_mereni>max_zelena && hodnota_mereni<=max_cervena)
                 {return  -5+130+15/(max_cervena-max_zelena)*(hodnota_mereni-max_zelena)}
             // pro druhou cervenou
             if (hodnota_mereni>max_cervena && hodnota_mereni<=max_hodnota)
                {return  -5+145+15/(max_hodnota-max_cervena)*(hodnota_mereni-max_cervena)}
             //kdyz je vsechno blbe
              if (hodnota_mereni<min_hodnota || hodnota_mereni>max_hodnota)
                 { return  10}
                        }


        function barva_cisla()
            {
             // pro prvni cervenou
            if (hodnota_mereni>=min_hodnota && hodnota_mereni<=min_cervena)
                {barva_pozadi = "#ea0909"
                return  "white"}
             // pro prvni zlutou
             if (hodnota_mereni>min_cervena && hodnota_mereni<=min_zelena)
                {barva_pozadi = "transparent"
                 return  "#fee001"}
             // pro zelenou
             if (hodnota_mereni>min_zelena && hodnota_mereni<=max_zelena)
                {barva_pozadi = "transparent"
                 return  "white"}
             // pro druhou zlutou
             if (hodnota_mereni>max_zelena && hodnota_mereni<=max_cervena)
                 {barva_pozadi = "transparent"
                 return  "#fee001"}
             // pro druhou cervenou
             if (hodnota_mereni>max_cervena && hodnota_mereni<=max_hodnota)
                {barva_pozadi = "#ea0909"
                 return  "white"}
             //kdyz je vsechno blbe
              if (hodnota_mereni<min_hodnota || hodnota_mereni>max_hodnota)
                 { //barva_pozadi = "#ea0909"
                  return  "#fffff"}
                        }





        Rectangle {
            id: rectangle
            color: barva_pozadi
            z: -41.848
            anchors.fill: parent
        }

    Rectangle {
        id: rectangle1
        x: 20
        y: 10
        width: 160
        height: 24
        color: "#ea0909"
        border.width: 2
        anchors.horizontalCenterOffset: 15
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: rectangle2
            x: 33
            y: 0
            width: 130
            height: 20
            color: "#fee001"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: rectangle3
            width: 100
            height: 20
            color: "#4cff22"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: posuvnik
            x: -2
            y: -5
            width: 10
            height: 30
            color: "#ffffff"
            //anchors.leftMargin: connection.hodnota_posuvniku
            anchors.leftMargin: id_root.hodnota_posuvniku
            anchors.verticalCenter: parent.verticalCenter
            border.color: "#281b1b"
            opacity: 1
            anchors.left: parent.left
            border.width: 1
        }
    }

    Text {
        id: id_hodnota_mereni
        x: 196
        y: 8
        color: barva_textu
        text: id_root.hodnota_mereni
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignLeft
        font.bold: true
        style: Text.Normal
        font.pixelSize: 25
    }

    Text {
        id: id_text_mereni
        y: 10
        width: 74
        height: 50
        color: barva_textu
        //text: qsTr("Text")
        text: connection.text_mereni
        verticalAlignment: Text.AlignVCenter
        anchors.right: rectangle1.left
        anchors.rightMargin: 10
        horizontalAlignment: Text.AlignRight
        font.bold: true
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 25
    }


}



/*##^##
Designer {
    D{i:0;height:40;width:320}D{i:1;anchors_height:200;anchors_width:200}D{i:6;anchors_x:196}
}
##^##*/
