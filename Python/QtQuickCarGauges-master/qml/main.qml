import QtQuick 2.1
import QtQuick.Window 2.1

Window
{
    id : mainScreen
    width: 640
    height: 480

    Rectangle
    {
        id : main_cadran
        color : "black"
        anchors.fill: parent
        Component.onCompleted: forceActiveFocus();

        property real randVal : 0;

        Keys.onSpacePressed:
        {
            randVal = Math.random();
        }
        RoundGauge
        {
            id : tacho_gauge
            width: 250
            height: 250
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 0
            outerCirclingColor: "#ff2200"
            Font.pointSize : 35
            Font.family : "Helvetica"
            Font.bold : true
            Font.italic : true
            unit: "RPM"
            unitFont.pointSize: 20
            unitFont.bold: true
            unitFont.italic: true
            unitFont.family: "Helvetica"
            digitalFont.family : "Helvetica"
            digitalFont.bold : true
            digitalFont.italic : true
            digitalFont.pointSize: 20
            currentValue: parent.randVal * (maxValue - minValue) + minValue;
            subDivs: 2
            minValue: 0
            maxValue: 7
            lowValues: 1
            highValues: 5
        }

        RoundGauge
        {
            id : fuel_level
            x: 456
            width: 150
            height: 150
            anchors.horizontalCenter: tacho_gauge.horizontalCenter
            anchors.top: tacho_gauge.bottom
            anchors.topMargin: 0
            anchors.left: water_temp.right
            anchors.leftMargin: 56
            indicatorWidth: 5
            unit : "Fuel"
            minValue: 0
            maxValue: 60
            lowValuesColor: "#cc0000"
            subDivs: 2
            lowValues: 10
            highValues: maxValue
            unitFont.pointSize: 10
            Font.pointSize : 6
            digitalFont.pointSize: 10
            currentValue: main_cadran.randVal *  (maxValue - minValue) + minValue;
        }

        Item
        {
            id : dashboard
            property int gaugeWidth : width * 0.25;
            property int gaugeHeight : height * 0.5
            width: 390
            height: 480
            anchors.left: tacho_gauge.right
            anchors.leftMargin: 0
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
                Font.pointSize : 6
                digitalFont.pointSize: 10
                currentValue: main_cadran.randVal *  (maxValue - minValue) + minValue;

            }
            RoundGauge
            {
                id : oil_temp
                anchors
                {
                    horizontalCenter : parent.horizontalCenter
                    top : parent.top
                }
                indicatorWidth: 5
                unit : "Oil C"
                width : dashboard.gaugeWidth
                height : dashboard.gaugeHeight
                minValue: 0
                maxValue: 250
                subDivs: 1
                lowValues: 50
                highValues: 150
                Font.pointSize : 6
                unitFont.pointSize: 10
                digitalFont.pointSize: 10
                currentValue: main_cadran.randVal *  (maxValue - minValue) + minValue;
            }
            GraphGauge
            {
                id : graph_gauge
                width : dashboard.gaugeWidth
                height : dashboard.gaugeHeight
                minValue: 0
                maxValue: 60
                subDivs: 4
                anchors
                {
                    left : fuel_level.right
                    top : parent.top
                }
                //                currentValue: main_cadran.randVal *  (maxValue - minValue) + minValue;
                currentValue: 30
            }

            RoundGauge
            {
                id : oil_pressure
                y: 32
                width: 150
                height: 150
                anchors.bottomMargin: 64
                anchors.leftMargin: -124
                anchors
                {
                    left : water_temp.horizontalCenter
                    bottom : parent.bottom
                }
                indicatorWidth: 5
                unit : "Oil PSI"
                minValue: 0
                maxValue: 10
                lowValuesColor: "#cc0000"
                subDivs: 9
                lowValues: 2
                highValues: 8
                unitFont.pointSize: 10
                Font.pointSize : 6
                digitalFont.pointSize: 10
                currentValue: main_cadran.randVal *  (maxValue - minValue) + minValue;
            }
            RoundGauge
            {
                id : fuel_pressure
                width : dashboard.gaugeWidth
                height : dashboard.gaugeHeight
                anchors
                {
                    right : fuel_level.horizontalCenter
                    bottom : parent.bottom
                }
                indicatorWidth: 5
                unit : "Fuel PSI"
                minValue: 0
                maxValue: 10
                lowValuesColor: "#cc0000"
                subDivs: 9
                lowValues: 2
                highValues: 8
                unitFont.pointSize: 10
                Font.pointSize : 6
                digitalFont.pointSize: 10
                currentValue: main_cadran.randVal *  (maxValue - minValue) + minValue;
            }
        }

    }
}

/*##^##
Designer {
    D{i:3;anchors_x:206;anchors_y:0}D{i:1;anchors_height:480;anchors_width:640}
}
##^##*/
