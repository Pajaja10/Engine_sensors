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
        property color barva_speed: "#98FB98"


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


    Rectangle
    {
        id : main_cadran
        opacity: 1
        anchors.fill: parent
        Component.onCompleted: forceActiveFocus();

        property real randVal : 0;

        Image {
            id: image
            z: 12.5
            anchors.fill: parent
            source: "zada.jpeg"
            fillMode: Image.PreserveAspectCrop
        }

        RoundGauge
        {
            id : tacho_gauge
            width: 300
            height: 300
            z: 29.891
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 0
            //outerCirclingColor: "#ff2200"
            outerCirclingColor: connection.barva_speed

            unit: "RPM"
            unitFont.pointSize: 25
            unitFont.bold: true
            unitFont.italic: true
            unitFont.family: "Helvetica"
            digitalFont.family : "Helvetica"
            digitalFont.bold : true
            digitalFont.italic : true
            digitalFont.pointSize: 20
            currentValue: connection.rpm / 1000;

            subDivs: 6
            minValue: 0
            maxValue: 7
            lowValues: 1
            highValues: 5



        }

        RoundGauge
        {
            id : fuel_level
            width: 150
            height: 150
            anchors.left: parent.left
            anchors.leftMargin: 0
            z: 32.065
            anchors.top: tacho_gauge.bottom
            anchors.topMargin: 2
            indicatorWidth: 5
            unit : "Fuel"
            minValue: 0
            maxValue: 60
            lowValuesColor: "#cc0000"
            subDivs: 2
            lowValues: 10
            highValues: maxValue
            unitFont.pointSize: 10

            digitalFont.pointSize: 10
            currentValue: connection.fuel;
        }

        RoundGauge
        {
            id : voltmeter_level
            width: 150
            height: 150
            anchors.top: tacho_gauge.bottom
            anchors.topMargin: 2
            anchors.left: fuel_level.right
            anchors.leftMargin: 0
            z: 32.065
            indicatorWidth: 5
            unit : "Baterie V"
            minValue: 10
            maxValue: 15
            lowValuesColor: "#cc0000"
            subDivs: 4
            lowValues: 11.5
            highValues: maxValue
            unitFont.pointSize: 10

            digitalFont.pointSize: 10
            currentValue: connection.voltmeter;
        }

        Item
        {
            id : dashboard
            property int gaugeWidth : width * 0.25;
            property int gaugeHeight : height * 0.5
            width: 300
            height: 300
            z: 34.239
            anchors.left: tacho_gauge.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter


            RoundGauge
            {
                id : water_temp
                width: 150
                height: 150
                anchors
                {
                    left : parent.left
                    top : parent.top
                }
                indicatorWidth: 5
                unit : "Water C"
                minValue: -20
                maxValue: 200
                subDivs: 1
                lowValues: 30
                highValues: 150
                unitFont.pointSize: 10

                digitalFont.pointSize: 10
                currentValue: connection.temp_water;

            }
            RoundGauge
            {
                id : oil_temp
                width: 150
                height: 150
                anchors.left: water_temp.right
                anchors.leftMargin: 0
                anchors
                {
                    top : parent.top
                }
                indicatorWidth: 5
                unit : "Oil C"
                minValue: 0
                maxValue: 250
                subDivs: 1
                lowValues: 50
                highValues: 150

                unitFont.pointSize: 10
                digitalFont.pointSize: 10
                currentValue: connection.temp_oil;
            }

            RoundGauge
            {
                id : oil_pressure
                width: 150
                height: 150
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: water_temp.bottom
                anchors.topMargin: 0
                indicatorWidth: 5
                unit : "Oil PSI"
                minValue: 0
                maxValue: 10
                lowValuesColor: "#cc0000"
                subDivs: 9
                lowValues: 2
                highValues: 8
                unitFont.pointSize: 10

                digitalFont.pointSize: 10
                currentValue: connection.pressure_oil;
            }
            RoundGauge
            {
                id : fuel_pressure
                width: 150
                height: 150
                anchors.left: oil_pressure.right
                anchors.leftMargin: 0
                anchors.top: oil_temp.bottom
                anchors.topMargin: 0
                indicatorWidth: 5
                unit : "Fuel PSI"
                minValue: 0
                maxValue: 10
                lowValuesColor: "#cc0000"
                subDivs: 9
                lowValues: 2
                highValues: 8
                unitFont.pointSize: 10

                digitalFont.pointSize: 10
                currentValue: connection.pressure_fuel;
            }
        }


    }
}



/*##^##
Designer {
    D{i:5;anchors_x:456}D{i:6;anchors_x:456}
}
##^##*/
