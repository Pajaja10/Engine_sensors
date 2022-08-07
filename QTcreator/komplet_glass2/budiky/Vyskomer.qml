import QtQuick 2.0

Item {
    id: element
    width: 260
    height: 260
    property int value: 1600

    Image {
        id: obruba
        x: 62
        y: 54
        width: 260
        height: 260
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 100
        source: "alt_case.svg"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: cifernik
        x: 62
        y: 54
        width: 260
        height: 260
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 20
        source: "alt_face_2.png"
        fillMode: Image.PreserveAspectFit
    }
    Image {
        id: image3
        x: 62
        y: 54
        width: 260
        height: 260
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        z: 20
        source: "alt_face_3.svg"
        fillMode: Image.PreserveAspectFit
    }

    Behavior on value {
        NumberAnimation {
            duration: 1000
        }}

    Image {
        id: baro
        x: 0
        y: 0
        width: 260
        height: 260
        z: -5
        transform: Rotation { origin.x: 130; origin.y: 130; angle: value/2}
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "alt_face_1.svg"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: rucicka2
        width: 260
        height: 260
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 100
        source: "alt_hand_2.svg"
        fillMode: Image.PreserveAspectFit
        transform: Rotation { origin.x: 130; origin.y: 130; angle: value*360/1000}
    }

    Image {
        id: rucicka1
        width: 260
        height: 260
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 80
        source: "alt_hand_1.svg"
        fillMode: Image.PreserveAspectFit
        transform: Rotation { origin.x: 130; origin.y: 130; angle: value*360/10000}
    }

}

/*##^##
Designer {
    D{i:0;height:240;width:240}D{i:1;anchors_height:260;anchors_width:260;anchors_x:62;anchors_y:54}
D{i:2;anchors_height:260;anchors_width:260;anchors_x:62;anchors_y:54}D{i:3;anchors_height:260;anchors_width:260;anchors_x:62;anchors_y:54;invisible:true}
D{i:6;anchors_height:100;anchors_width:100}D{i:8;anchors_height:100;anchors_width:100}
}
##^##*/
