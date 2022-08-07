import os
#os.chdir('C:\\Users\\prozp\\Dropbox\\Python\\pristroje_5')
import sys
import random 
from PyQt5 import QtCore, QtGui, QtWidgets, QtQml, QtQuick, QtQuickWidgets
from analog_arduino import Vstupy
from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, QUrl, QTimer, QDateTime
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

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
        #print(self.vstupyValue)
        

class MainWindow(QtWidgets.QMainWindow):
 
    def __init__(self, parent=None):
        QtWidgets.QMainWindow.__init__(self, parent)
        self.qmlWidget = QtQuickWidgets.QQuickWidget()
        self.setCentralWidget(self.qmlWidget)
        self.qmlWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeViewToRootObject)
        self.setGeometry(0, -1, 600, 1026) #0, -1, 600, 1026
        #self.showMaximized()
        
class MainWindow2(QtWidgets.QMainWindow):
 
    def __init__(self, parent=None):
        QtWidgets.QMainWindow.__init__(self, parent)
        self.qmlWidget2 = QtQuickWidgets.QQuickWidget()
        self.setCentralWidget(self.qmlWidget2)
        self.qmlWidget2.setResizeMode(QtQuickWidgets.QQuickWidget.SizeViewToRootObject)


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = MainWindow()    #Main window written in pyqt5
    #window2 = MainWindow2() 
    pristrojeWidget = MyClass() # Class with function to update data in QML
    context = window.qmlWidget.rootContext()
    #context2 = window2.qmlWidget2.rootContext()
    context.setContextProperty("pristrojeWidget",pristrojeWidget)
    #context2.setContextProperty("pristrojeWidget",pristrojeWidget)
    window.qmlWidget.setSource(QtCore.QUrl('budiky2/main.qml'))
    #window2.qmlWidget2.setSource(QtCore.QUrl('budiky2/main.qml'))
    timer = QtCore.QTimer()
    timer.timeout.connect(pristrojeWidget.vstupy_value)
    timer.start(200)
    window.show()
    #window2.show()
    sys.exit(app.exec_())

#if __name__ == "__main__":
#    app = QGuiApplication(sys.argv)
#    obj = Foo()
#    timer = QTimer()
#    timer.timeout.connect(update_value)
#    timer.start(100)
#    engine = QQmlApplicationEngine()
#    engine.rootContext().setContextProperty("obj", obj)
#    engine.load(QUrl("main.qml"))
#    if not engine.rootObjects():
#        sys.exit(-1)
#    sys.exit(app.exec_())

#if __name__ == "__main__":
#    app = QtWidgets.QApplication(sys.argv)
#    window = GUI_MainWindow()    #Main window written in pyqt5
#    QtQml.qmlRegisterType(RadialBar, "SDK", 1,0, "RadialBar")
#    batteryWidget = MyClass() # Class with function to update data in QML
#    context = window.batteryCWidget.rootContext()
#    context.setContextProperty("batteryWidget",batteryWidget)
#v    window.batteryCWidget.setSource(QtCore.QUrl('\\qml_widget.qml'))
#    timer = QtCore.QTimer()
#    timer.timeout.connect(batteryWidget.vstupy_value)
#    timer.start(200)
#    window.show()
#    sys.exit(app.exec_())

