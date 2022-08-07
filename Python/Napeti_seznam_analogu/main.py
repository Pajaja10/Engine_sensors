import os
#os.chdir('C:\\Users\\prozp\\Dropbox\\Python\\pristroje_3')
import sys
import random 
from PyQt5 import QtCore, QtGui, QtWidgets, QtQml, QtQuick, QtQuickWidgets
from RadialBar import RadialBar
from analog_data import Vstupy

class MyClass(QtCore.QObject):
    vstupyChanged = QtCore.pyqtSignal(list)
    v1 = []
    vstupyValue = []

    def __init__(self, parent=None):
        super(MyClass, self).__init__(parent)
        self.m_vstupyValue = []

    @QtCore.pyqtProperty(list, notify=vstupyChanged)
    def vstupyValue(self):
        return self.m_vstupyValue

    @vstupyValue.setter
    def vstupyValue(self, v1):
        if self.m_vstupyValue == v1:
            return
        self.m_vstupyValue = v1
        self.vstupyChanged.emit(v1)

    def vstupy_value(self):
        v1 = Vstupy.analog_hodnoty()
        self.vstupyValue = v1

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
    window.batteryCWidget.setSource(QtCore.QUrl('qml_widget.qml'))
    timer = QtCore.QTimer()
    timer.timeout.connect(batteryWidget.vstupy_value)
    timer.start(200)
    window.show()
    sys.exit(app.exec_())