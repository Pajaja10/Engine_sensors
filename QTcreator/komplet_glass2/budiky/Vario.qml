import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0





Rectangle {
    id: vario_id
    color: "transparent"
    border.color: "#00000000"
    width: 200
    height: 200
    property color barvaCervena: "#ea0909"
    property color barvaZluta : "yellow"
    property color barvaZelena : "#4cff22"
    property real  value : 0

    CircularGauge {
        id: gauge
        width: 200
        height: 200
        anchors.fill: parent
        value: vario_id.value
        maximumValue : 10
        minimumValue : -10

        Behavior on value {
            NumberAnimation {
                duration: 1000
            }}


        style: CircularGaugeStyle {
            id: style

            maximumValueAngle : 405
            minimumValueAngle : 135
            tickmarkStepSize : 2
            //tickmarkCount : 5
            labelInset : 30   //poloha čísel od vnějšku
            labelStepSize : 2
            minorTickmarkCount : 1


            function degreesToRadians(degrees) {
                return degrees * (Math.PI / 180);
            }

            /*background: Canvas {
                onPaint: {
                    var ctx = getContext("2d");
                   //červený kruh
                    ctx.beginPath();
                    ctx.strokeStyle = barvaCervena;
                    ctx.lineWidth = outerRadius * 0.07;
                    ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                        degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(70) - 90));
                    ctx.stroke();
                   //zelený kruh
                    ctx.beginPath();
                    ctx.strokeStyle = barvaZelena;
                    ctx.lineWidth = outerRadius * 0.07;
                    ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                        degreesToRadians(valueToAngle(100) - 90), degreesToRadians(valueToAngle(200) - 90));
                    ctx.stroke();
                    //žlutý první kruh
                    ctx.beginPath();
                    ctx.strokeStyle = barvaZluta;
                    ctx.lineWidth = outerRadius * 0.07;
                    ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                        degreesToRadians(valueToAngle(70) - 90), degreesToRadians(valueToAngle(100) - 90));
                    ctx.stroke();
                    //žlutý druhý kruh
                    ctx.beginPath();
                    ctx.strokeStyle = barvaZluta;
                    ctx.lineWidth = outerRadius * 0.07;
                    ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                        degreesToRadians(valueToAngle(200) - 90), degreesToRadians(valueToAngle(240) - 90));
                    ctx.stroke();
                }
            }*/

            tickmark: Rectangle {
                visible: {
                styleData.value >= -6 && styleData.value <= 6 ||
                styleData.value === 10 || styleData.value === -10
                }

                implicitWidth: outerRadius * 0.04
                antialiasing: true
                implicitHeight: outerRadius * 0.12
                color: "#FFFFFF"
            }

            minorTickmark: Rectangle {
                visible: styleData.value >= -6 && styleData.value <= 6
                implicitWidth: outerRadius * 0.022
                antialiasing: true
                implicitHeight: outerRadius * 0.05
                color: "#FFFFFF"
            }

            tickmarkLabel:  Text {
                visible: {
                styleData.value === 0 || styleData.value === 2 ||
                styleData.value === 6 || styleData.value === 10 ||
                styleData.value === -2 || styleData.value === -6 ||
                styleData.value === -10
                }
                font.pixelSize: 18
                text: styleData.value
                color: "#FFFFFF"
                //color: styleData.value >= 80 ? "#e34c22" : "#e5e5e5"
                antialiasing: true
            }

            needle: Rectangle {

                y: 260/2 //outerRadius
                //x: outerRadius/2
                implicitWidth: 260 //outerRadius *2
                implicitHeight: 260 //outerRadius  *2
                //antialiasing: false
                color: "transparent"

                Image
                {
                    //height: 220
                    //width: 10
                    source : "needle_vario.png"
                    anchors.fill: parent
                    //transform: Translate {  y: 0}
                    //fillMode: Image.PreserveAspectFit
                    /*fillMode: Image.PreserveAspectFit
                    width : parent.width + needle_holder.width * 0.7
                    x : -needle_holder.width *0.7
                    smooth : true*/
                }



            }

            foreground: Item {
                Rectangle {
                    width: outerRadius * 0.2
                    height: width
                    radius: width / 2
                    color: "transparent"
                    anchors.centerIn: parent
                }
            }
        }

        Text {
            id: element
            x: 138
            width: 140
            height: 50
            text: Math.round(value) + " m/s"
            anchors.top: parent.top
            anchors.topMargin: 95
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 18
            color: "#FFFFFF"
        }

        Rectangle {
            id: rectangle
            width: 180
            height: 180
            color: "transparent"
            radius: 155
            border.width: 3
            border.color: "#FFFFFF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: element1
            color: "#ffffff"
            text: qsTr("VARIO")
            font.bold: true
            anchors.bottom: element.top
            anchors.bottomMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 18
        }



    }


    Image {
        id: image
        width: 240
        height: 240
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "alt_case.svg"
        fillMode: Image.PreserveAspectFit
    }
}

/*##^##
Designer {
    D{i:0;height:180;width:180}D{i:10;anchors_y:71}D{i:13;anchors_height:100;anchors_width:100}
}
##^##*/
