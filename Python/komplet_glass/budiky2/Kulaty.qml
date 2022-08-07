import QtQuick 2.2

Canvas
{
    id : gauge_canvas
    contextType: "2d"
    antialiasing: true;

    property real value : 0;
    property real min_hodnota: 0
    property real max_hodnota: 20
    property real max_cervena: 19
    property real min_zelena: 3
    property real max_zelena: 17



    property color lowValuesColor : "yellow";
    property color highValuesColor : "#ea0909";
    property color middleValuesColor : "yellow"
    property color rightValuesColor : "#4cff22"
    property color innerCirclingColor : "white";
    property color outerCirclingColor : "#0099FF";
    property color textColor : "white";

    property bool  digitalEnable : true
    property alias digitalFont : digital_readout.font
    property bool  fullCircle : false
    property int   indicatorWidth : 10
    property color barva_pozadí : "transparent"
    property color barva_textu : barva_cisla()

    height: 216

    function barva_cisla()
    {    //pro prvni zlutou
        if (value>=min_hodnota && value<=min_zelena)
        {barva_pozadí = "transparent"
            return  lowValuesColor}

        // pro zelenou
        if (value>min_zelena && value<=max_zelena)
           { barva_pozadí = "transparent"
            return  "white"}

        // pro druhou zlutou
        if (value>max_zelena && value<=max_cervena)
        {barva_pozadí = "transparent"
            return  middleValuesColor}

        // pro druhou cervenou
        if (value>max_cervena && value<=max_hodnota)
        {barva_pozadí = highValuesColor
        return  "white"}

        //kdyz je vsechno blbe
        if (value<min_hodnota || value>max_hodnota)
            return  "black"
    }

    Canvas
    {
        id : value_timer
        contextType: "2d"
        antialiasing: true;

        function getCadranColor()
        {    //pro prvni zlutou
            if (value>=min_hodnota && value<=min_zelena)
                return  lowValuesColor

            // pro zelenou
            if (value>min_zelena && value<=max_zelena)
                return  rightValuesColor

            // pro druhou zlutou
            if (value>max_zelena && value<=max_cervena)
                return  middleValuesColor

            // pro druhou cervenou
            if (value>max_cervena && value<=max_hodnota)
                return  highValuesColor

            //kdyz je vsechno blbe
            if (value<min_hodnota || value>max_hodnota)
                return  "white"
        }


        property color targetColor : getCadranColor();
        anchors.right: parent.left
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.top
        anchors.bottomMargin: 0


        onPaint:
        {
            context.reset();
            context.beginPath();
            context.lineWidth = 42;
            context.strokeStyle = targetColor;
            context.arc(d.center.x, d.center.y, d.radius -42 - 3.5 - indicatorWidth * 0.5, d.startAngle, d.needleAngleRad);
            context.stroke();
        }
    }

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
        Behavior on needleAngleRad {SpringAnimation {spring: 4; damping: 0.5;}}
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
        context.arc(d.center.x, d.center.y, d.radius - (10 + indicatorWidth), d.startAngle, d.startAngle + ((max_hodnota - min_hodnota) / d.range) * (d.wholeAngle));
        context.stroke();


        // DRAW LOW VALUE ARC nakreslí flek modrý
        context.beginPath();
        context.lineWidth = 20;
        context.strokeStyle = lowValuesColor;
        context.arc(d.center.x, d.center.y, d.radius - (10 + indicatorWidth), d.startAngle, d.startAngle + ((min_zelena - min_hodnota) / d.range) * (d.wholeAngle));
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

    Rectangle {
        id: rectangle
        width: 80
        height: 38
        color: barva_pozadí
        anchors
        {
            top : needle_holder.bottom
            topMargin : needle_holder.width * 0.3
            horizontalCenter : parent.horizontalCenter
        }

        Text
        {
            id : digital_readout
            visible : digitalEnable
            text : Math.round(value * 10) / 10;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pointSize: 25
            style : Text.Sunken
            styleColor: outerCirclingColor
            color : barva_textu
        }
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
    D{i:0;height:216;width:216}D{i:4;anchors_x:1;anchors_y:0}
}
##^##*/
