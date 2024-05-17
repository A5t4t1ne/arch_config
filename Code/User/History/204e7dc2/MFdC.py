import sys
from PyQt5.QtWidgets import QApplication, QLabel, QMainWindow, QScrollArea, QVBoxLayout, QWidget
from PyQt5.QtGui import QPixmap
from PyQt5.QtCore import Qt

class ImageWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        # Load the large image
        pixmap = QPixmap("path_to_large_image.jpg")

        # Create a label to display the image
        label = QLabel(self)
        label.setPixmap(pixmap)

        # Create a scroll area
        scroll_area = QScrollArea()
        scroll_area.setWidget(label)

        # Set the central widget of the main window
        self.setCentralWidget(scroll_area)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = ImageWindow()
    window.show()
    sys.exit(app.exec_())
