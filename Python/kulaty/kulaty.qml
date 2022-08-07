import QtQuick 2.2

Canvas
{
    id : gauge_canvas
    contextType: "2d"
    antialiasing: true;

    property real value : 0;
    property real min_hodnota: 0
    property real max_hodnota: 20
    property real min_cervena: 1
    property real max_cervena: 19
    // prubeh zeleny
    property real min_zelena: 3
    property real max_zelena: 17



    property color lowValuesColor : "#0066FF";
    property color highValuesColor : "#cc0000";
    property color middleValuesColor : "yellow"
    property color rightValuesColor : "green"
    property color innerCirclingColor : "white";
    property color outerCirclingColor : "#0099FF";
    property color textColor : "white";
    property color graduationColor : "white";
    property color backgroundColor : "black";
    property bool  digitalEnable : true
    property alias digitalFont : digital_readout.font
    //property alias unit : measure_unit.text
    //property alias unitFont : measure_unit.font
    property bool  fullCircle : false
    property int   indicatorWidth : 10

    QtObject
    {
        id : d
        property real range : max_hodnota - min_hodnota;
        property real startAngle : Math.PI * 0.9;
        property real endAngle : Math.PI * 2.1;
        property real radius : Math.min(width * 0.5, height * 0.5) - 10
        property point center : Qt.point(width * 0.5, height * 0.5)
        property real wholeAngle : endAngle - startAngle;
        property int animTimer;
        property real currentValueRatio : (value - min_hodnota) / d.range;
        property real needleAngleRad : d.startAngle + currentValueRatio * d.wholeAngle;
        property real needleAngle : needleAngleRad  * 180 / Math.PI;
        Behavior on needleAngleRad {SpringAnimation {spring: 1.5; damping: 0.5;}}
        onNeedleAngleRadChanged: value_timer.requestPaint();
    }

    // DRAWN ONCE
    onPaint:
    {
        context.beginPath();



        // DRAW LOW VALUE ARC nakreslí flek zelený
        context.beginPath();
        context.lineWidth = 20;
        context.strokeStyle = rightValuesColor;
        context.arc(d.center.x, d.center.y, d.radius - (10 + indicatorWidth), d.startAngle, d.startAngle + ((max_cervena - min_hodnota) / d.range) * (d.wholeAngle));
        context.stroke();


        // DRAW LOW VALUE ARC nakreslí flek modrý
        context.beginPath();
        context.lineWidth = 20;
        context.strokeStyle = lowValuesColor;
        context.arc(d.center.x, d.center.y, d.radius - (10 + indicatorWidth), d.startAngle, d.startAngle + ((min_cervena - min_hodnota) / d.range) * (d.wholeAngle));
        context.stroke();

        // DRAW  VALUE ARC nakreslí flek oranžová
        context.beginPath();
        context.lineWidth = 20;
        context.strokeStyle = middleValuesColor;
        context.arc(d.center.x, d.center.y, d.radius - (10 + indicatorWidth), d.endAngle - (((d.range  - (max_zelena - min_hodnota)) / d.range) * (d.wholeAngle)), d.endAngle);
        context.stroke();

        // DRAW HIGH VALUE ARC nakreslí flek červený
        context.beginPath();
        context.lineWidth = 20;
        context.strokeStyle = highValuesColor;
        context.arc(d.center.x, d.center.y, d.radius - (10 + indicatorWidth), d.endAngle - (((d.range  - (max_cervena - min_hodnota)) / d.range) * (d.wholeAngle)), d.endAngle);
        context.stroke();




    }



    // REDRAWN WHEN GAUGE VALUE CHANGES
    Canvas
    {
        id : value_timer
        anchors.fill: parent
        contextType: "2d"
        antialiasing: true;

        function getCadranColor()
        {
            if (value <= min_cervena)
                return Qt.rgba(lowValuesColor.r, lowValuesColor.g - ((value - min_cervena) / (min_hodnota - min_cervena)), lowValuesColor.b);
            else if (currentValue >= max_cervena)
                return Qt.rgba(highValuesColor.r, (1 - ((value - max_cervena) / (max_hodnota - max_cervena))) * 0.5, highValuesColor.b);
            else
            {
                var colorRatio = (value - min_cervena) / (max_cervena - min_cervena);
                return Qt.rgba(colorRatio, 1, (1 - colorRatio) * 0.5);
            }
        }

        property color targetColor : getCadranColor();
        Behavior on targetColor {ColorAnimation {duration: 750}}

        onPaint:
        {
            context.reset();
            context.beginPath();
            context.lineWidth = indicatorWidth;
            context.strokeStyle = targetColor;
            context.arc(d.center.x, d.center.y, d.radius - 3.5 - indicatorWidth * 0.5, d.startAngle, d.needleAngleRad);
            context.stroke();
        }
    }

    Text
    {
        id : digital_readout
        visible : digitalEnable
        anchors
        {
            top : needle_holder.bottom
            topMargin : needle_holder.width * 0.3
            horizontalCenter : parent.horizontalCenter
        }
        text : Math.round(value * 10) / 10;
        style : Text.Sunken
        styleColor: outerCirclingColor
        color : textColor
    }


    // NEEDLE HOLDER
    Rectangle
    {
        id : needle_holder
        width : d.radius * 0.4
        opacity : 0.8
        height: width
        radius: 180
        x : d.center.x - width * 0.5
        y : d.center.y - height * 0.5
        border
        {
            width : 1
            color : "white"
        }

        color : "black"
    }

    // NEEDLE
    Item
    {
        id : needle
        width : d.radius * 0.9
        height : needle_pic.height
        x : d.center.x
        y : d.center.y
        smooth : true

        Image
        {
            id : needle_pic
            source : "needle.png"
            fillMode: Image.PreserveAspectFit
            width : parent.width + needle_holder.width * 0.7
            x : -needle_holder.width *0.7
            smooth : true
        }

        transform : Rotation {
            angle : d.needleAngle
            axis { x : 0; y : 0; z : 1}
        }
    }

    Rectangle
    {
        width : d.radius * 0.1
        height : width
        radius : 180
        color : innerCirclingColor
        x : d.center.x - width * 0.5
        y : d.center.y - height * 0.5
        border
        {
            width : 1
            color : innerCirclingColor
        }
    }

}

/*##^##
Designer {
    D{i:0;height:300;width:300}
}
##^##*/
