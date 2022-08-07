import QtQuick 2.1
import QtQuick.Window 2.1

Item
{
    id : mainScreen
    width: 640
    height: 480

    Connections{
        id : connection
        target: pristrojeWidget
        property var actValueList
        property double rpm
        property double fuel
        property double temp_water
        property double temp_oil
        property double pressure_oil
        property double pressure_fuel
        property double voltmeter : 10
        property color barva_speed: "f00000"


        onVstupyChanged: {
            actValueList = pristrojeWidget.vstupyValue
            rpm = actValueList[0] * 7000
            fuel = actValueList[1] * 60
            temp_water = actValueList[2] * 220 - 20
            temp_oil = actValueList[3] * 250
            pressure_oil = actValueList[4] * 10
            pressure_fuel = actValueList[5] * 10
            voltmeter = actValueList[5] * 4 + 10
            //pravyBlinkr = actValueList[8]
            //levyBlinkr = actValueList[9]
            if (rpm < 1000 ){parent.barva_speed =  "#87CEEB"}
            else{
                if (rpm > 5000 ){parent.barva_speed =  "#FF0000"}
                else {parent.barva_speed = "#98FB98"}
            }

        }
    }


    RoundGauge
    {
        id : tacho_gauge
        x: 0
        y: 20
        width: 300
        height: 300
        z: 29.891
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 0
        //outerCirclingColor: "#ff2200"
        outerCirclingColor: connection.barva_speed

        //unit: "RPM"
        //unitFont.pointSize: 25
        //unitFont.bold: true
        //unitFont.italic: true
        //unitFont.family: "Helvetica"
        digitalFont.family : "Helvetica"
        digitalFont.bold : true
        digitalFont.italic : true
        digitalFont.pointSize: 20
        value: connection.rpm / 1000;
        min_hodnota: 0
        max_hodnota: 20
        min_cervena: 1
        max_cervena: 19
        // prubeh zeleny
        min_zelena: 3
        max_zelena: 17




    }

}






