import os
#os.chdir(path)
from gpiozero import MCP3008
import sys

from random import randrange

from PyQt5 import QtCore, QtGui, QtWidgets, QtQml, QtQuick, QtQuickWidgets

from RadialBar import RadialBar

class MyClass(QtCore.QObject):
    randomValueChanged = QtCore.pyqtSignal(float)

    def __init__(self, parent=None):
        super(MyClass, self).__init__(parent)
        self.m_randomValue = 0

    @QtCore.pyqtProperty(float, notify=randomValueChanged)
    def randomValue(self):
        return self.m_randomValue

    @randomValue.setter
    def randomValue(self, v):
        if self.m_randomValue == v:
            return
        self.m_randomValue = v
        self.randomValueChanged.emit(v)

    def random_value(self):
        with MCP3008(channel=0) as reading:
            v = (round((reading.value * 200), 2))
        print(v)
        self.randomValue = v

class GUI_MainWindow(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        QtWidgets.QMainWindow.__init__(self, parent)
        self.batteryCWidget = QtQuickWidgets.QQuickWidget()
        self.setCentralWidget(self.batteryCWidget)
        self.batteryCWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = GUI_MainWindow()    #Main window written in pyqt5
    QtQml.qmlRegisterType(RadialBar, "SDK", 1,0, "RadialBar")
    batteryWidget = MyClass() # Class with function to update data in QML
    context = window.batteryCWidget.rootContext()
    context.setContextProperty("batteryWidget",batteryWidget)
    window.batteryCWidget.setSource(QtCore.QUrl.fromLocalFile('qml_widget.qml'))
    timer = QtCore.QTimer()
    timer.timeout.connect(batteryWidget.random_value)
    timer.start(200)
    window.show()
    sys.exit(app.exec_())