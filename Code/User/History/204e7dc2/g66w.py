import sys
from PyQt6.QtWidgets import QApplication, QMainWindow, QGraphicsView, QGraphicsScene
from PyQt6.QtGui import QPixmap, QImage
from PyQt6.QtCore import Qt
from PIL import Image
import io

class ImageWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        # Load the image using Pillow
        pil_image = Image.open("path_to_large_image.jpg")

        # Convert the Pillow image to a Qt image
        image_data = pil_image.tobytes()
        q_image = QImage(image_data, pil_image.width, pil_image.height, QImage.Format.Format_RGB888)

        # Create a QGraphicsScene and add the image to it
        scene = QGraphicsScene()
        scene.addPixmap(QPixmap.fromImage(q_image))

        # Create a QGraphicsView to display the scene
        view = QGraphicsView()
        view.setScene(scene)

        # Set the central widget of the main window
        self.setCentralWidget(view)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = ImageWindow()
    window.show()
    sys.exit(app.exec())
