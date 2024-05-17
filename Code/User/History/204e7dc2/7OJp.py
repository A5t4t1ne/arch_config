# import sys
# from PyQt6.QtWidgets import QApplication, QMainWindow, QGraphicsView, QGraphicsScene
# from PyQt6.QtGui import QPixmap, QImage
# from PyQt6.QtCore import Qt


# if __name__ == '__main__':
#     app = QApplication(sys.argv)
#     window = QMainWindow()
#     window.setWindowTitle("HelloThere")
#     window.setGeometry(400, 400, 800, 600)
#     window.show()
#     sys.exit(app.exec())

from PyQt6.QtWidgets import QApplication, QWidget, QPushButton
from PyQt6.QtCore import Qt, QMimeData
from PyQt6.QtGui import QDrag
import sys

class DragButton(QPushButton):
    def mouseMoveEvent(self, e):
        if e.buttons() == Qt.MouseButton.LeftButton:
            drag = QDrag(self)
            mime = QMimeData()
            drag.setMimeData(mime)
            drag.exec_(Qt.DropAction.MoveAction)

class Example(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setAcceptDrops(True)
        self.button = DragButton('Button', self)
        self.button.move(100, 65)
        self.setWindowTitle('Draggable Button')
        self.setGeometry(300, 300, 550, 450)

    def dragEnterEvent(self, e):
        e.accept()

    def dropEvent(self, e):
        position = e.pos()
        self.button.move(position)

if __name__ == '__main__':
    app = QApplication([])
    ex = Example()
    ex.show()
    sys.exit(app.exec())
