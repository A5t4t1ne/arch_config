import sys
from PyQt6.QtWidgets import QApplication, QMainWindow, QScrollArea, QVBoxLayout, QWidget
from PyQt6.QtGui import QPixmap
from PyQt6.QtCore import Qt
from PyQtImageViewer import QtImageViewer

class ImageWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        # Load the large image
        pixmap = QPixmap("path_to_large_image.jpg")

        # Create an instance of the QtImageViewer widget
        image_viewer = QtImageViewer()
        image_viewer.setPixmap(pixmap)

        # Create a scroll area and add the image viewer to it
        scroll_area = QScrollArea()
        scroll_area.setWidget(image_viewer)

        # Set the central widget of the main window
        self.setCentralWidget(scroll_area)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = ImageWindow()
    window.show()
    sys.exit(app.exec())
