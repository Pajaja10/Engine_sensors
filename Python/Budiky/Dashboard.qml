import QtQuick 2.1
import QtQuick.Window 2.1

Item
{
    id : dashboard
    property int gaugeWidth : width * 0.25;
    property int gaugeHeight : height * 0.5
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

        digitalFont.pointSize: 10
        currentValue: main_cadran.randVal *  (maxValue - minValue) + minValue;
    }
}
