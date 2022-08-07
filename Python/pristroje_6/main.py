import os
#os.chdir('C:\\Users\\prozp\\Dropbox\\Python\\pristroje_5')
import sys
import random 
from PyQt5 import QtCore, QtGui, QtWidgets, QtQml, QtQuick, QtQuickWidgets
from analog_data import Vstupy
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
        print(self.vstupyValue)

class MainWindow(QtWidgets.QMainWindow):
 
    def __init__(self, parent=None):
        QtWidgets.QMainWindow.__init__(self, parent)
        self.qmlWidget = QtQuickWidgets.QQuickWidget()
        self.setCentralWidget(self.qmlWidget)
        self.qmlWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = MainWindow()    #Main window written in pyqt5
    pristrojeWidget = MyClass() # Class with function to update data in QML
    context = window.qmlWidget.rootContext()
    context.setContextProperty("pristrojeWidget",pristrojeWidget)
    window.qmlWidget.setSource(QtCore.QUrl('budiky/main_window.qml'))
    timer = QtCore.QTimer()
    timer.timeout.connect(pristrojeWidget.vstupy_value)
    timer.start(300)
    window.show()
    sys.exit(app.exec_())
