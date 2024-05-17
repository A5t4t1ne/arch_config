import sys
from PyQt6.QtWidgets import QApplication, QMainWindow, QGraphicsView, QGraphicsScene
from PyQt6.QtGui import QPixmap, QImage
from PyQt6.QtCore import Qt


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = QMainWindow()
    window.setWindowTitle("HelloThere")
    window.setGeometry(400, 400, 800, 600)
    window.show()
    sys.exit(app.exec())
