import QtQuick 2.0

Item {
    id: element
    width: 240
    height: 240
    property int value: 80

    Image {
        id: image
        x: 62
        y: 54
        width: 260
        height: 260
        z: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "hsi_case.svg"
        fillMode: Image.PreserveAspectFit
    }

    Behavior on value {
        NumberAnimation {
            duration: 1000
        }}

    Image {
        id: image1
        width: 260
        height: 260
        transform: Rotation { origin.x: 130; origin.y: 130; angle: value}
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "hsi_face.svg"
        fillMode: Image.PreserveAspectFit
    }

}

/*##^##
Designer {
    D{i:0;height:240;width:240}D{i:1;anchors_height:100;anchors_width:100;anchors_x:62;anchors_y:54}
}
##^##*/
