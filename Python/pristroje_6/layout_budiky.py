import os
#os.chdir('C:\\Users\\prozp\\Dropbox\\Python\\pristroje_5')
import sys
import random 
from PyQt5 import QtCore, QtGui, QtWidgets, QtQml, QtQuick, QtQuickWidgets
from analog_data import Vstupy
from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, QUrl, QTimer, QDateTime
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QWidget, QApplication, QGridLayout


class MainWindow(QtWidgets.QMainWindow):
 
    def __init__(self, parent=None):
        QtWidgets.QGridLayout.__init__(self, parent)
        #definuje prvky: mrizku, widgety pro qml, talčítka na blinkry
        mrizka = QGridLayout()
        self.qmlSpeed = QtQuickWidgets.QQuickWidget()
        self.qmlTeplota = QtQuickWidgets.QQuickWidget()
        self.qmlTlak = QtQuickWidgets.QQuickWidget()
        self.qmlFuel = QtQuickWidgets.QQuickWidget()
        self.qmlGear = QtQuickWidgets.QQuickWidget()
        self.qmlBlinkry = QtQuickWidgets.QQuickWidget()
        
        #levyBlinkr=QtGui.QRadioButton(u"Muž",mainWidget)
        #pravyBlinkr=QtGui.QRadioButton(u"Žena",mainWidget)

        mrizka.addWidget(self.qmlSpeed, 1, 1)
        mrizka.addWidget(self.qmlTeplota, 2, 1)
        mrizka.addWidget(self.qmlTlak, 3, 1)
        mrizka.addWidget(self.qmlFuel, 1, 2)
        mrizka.addWidget(self.qmlGear, 2, 2)
        mrizka.addWidget(self.qmlBlinkry, 3, 2)
        # Vytvorime 2 prepinace

        self.qmlSpeed.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.qmlTeplota.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.qmlTlak.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.qmlFuel.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.qmlGear.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        self.qmlBlinkry.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)
        #self.teplotaWidget = QtQuickWidgets.QQuickWidget()
        #self.rychlostWidget = QtQuickWidgets.QQuickWidget()
        #vytvoření layoutu
        #self.setLayout(mrizka)
        #grid.addWidget(button, *position)
        #self.setCentralWidget(self.tlakWidget)
        #self.tlakWidget.setResizeMode(QtQuickWidgets.QQuickWidget.SizeRootObjectToView)

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = MainWindow()    #Main window written in pyqt5
    context = window.qmlWidget.rootContext()
    context.setContextProperty("pristrojeWidget",pristrojeWidget)
    #window.qmlWidget.setSource(QtCore.QUrl('Dashboard.qml'))
    window.show()
    sys.exit(app.exec_())