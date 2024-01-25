from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot
import sys
import os
import pymsgbox

class backend(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.path = "~/.pswdGen"
        os.makedirs(os.path.expanduser(self.path), exist_ok=True)

    @Slot(str, str, str)
    def add_new_user(self, name, pswd1, pswd2):
        if pswd1 == pswd2:
            try:
                os.mkdir(os.path.expanduser(self.path + "/" + name.lower()))
                pymsgbox.alert(f"User {name} added successfully!")
            except FileExistsError:
                pymsgbox.alert(f"User {name} already exists.\nTry logging in instead")
        else:
            pymsgbox.alert("Passwords do not match!")

app = QApplication(sys.argv)
page = QQmlApplicationEngine()

link = backend()
page.rootContext().setContextProperty("link", link)
page.quit.connect(app.quit)
page.load("src/main.qml")

sys.exit(app.exec())
