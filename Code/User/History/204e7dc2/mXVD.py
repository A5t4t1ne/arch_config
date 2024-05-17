import sys
from PyQt6.QtWidgets import QApplication, QMainWindow, QGraphicsView, QGraphicsScene
from PyQt6.QtGui import QPixmap, QImage
from PyQt6.QtCore import Qt

def window():
    app = QApplication(sys.argv)



if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = QMainWindow()
    window.statusBar().show_message("Hello there")
    window.show()
    sys.exit(app.exec())
