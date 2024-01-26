from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot
import sys
import os
import pymsgbox
import hashlib
from cryptography.fernet import Fernet
import base64


class backend(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.path = "~/.pswdManager"
        self.key = None
        self.name = None
        os.makedirs(os.path.expanduser(self.path), exist_ok=True)

    @Slot(str, str, str)
    def add_new_user(self, name, pswd1, pswd2):
        if pswd1 == pswd2:
            try:
                os.mkdir(os.path.expanduser(self.path + "/" + name.lower()))
                pswd_hashed = hashlib.sha1(pswd1.encode("UTF-8"))
                with open(os.path.expanduser(self.path + "/" + name.lower() + "/pswd"), "x") as f:
                    f.write(str(pswd_hashed.hexdigest()))
                pymsgbox.alert(f"User {name} added successfully!")
            except FileExistsError:
                pymsgbox.alert(f"User {name} already exists.\nTry logging in instead")
        else:
            pymsgbox.alert("Passwords do not match!")

    @Slot(str, str, result=bool)
    def log_in(self, name, pswd):
        pswd_hash = hashlib.sha1(pswd.encode("UTF-8"))
        self.key = pswd
        self.name = name.lower()
        if name.strip() == "":
            pymsgbox.alert("Log in Failed!")
            return False
        try:
            with open(os.path.expanduser(self.path + "/" + name.lower() + "/pswd"), "r") as f:
                    saved_hash = f.read().strip()
            if pswd_hash.hexdigest() == saved_hash:
                page.rootObjects()[0].setProperty("name_of_user", name.title())
                return True
            else:
                pymsgbox.alert("Log in Failed!")
                return False
        except:
            pymsgbox.alert(f"User {name} does not exist.\nTry to Sing up instead")
            return False
        
    @Slot(str, str, result=bool)
    def save_password(self, title, data):
        try:
            with open(os.path.expanduser(self.path + "/" + self.name + "/" + title), "r") as test:
                pymsgbox.alert(f"Password with title {title} already exists!!")
                return False
        except:
            try:
                key = hashlib.sha256(self.key.encode()).digest()
                fernet = Fernet(base64.urlsafe_b64encode(key))
                with open(os.path.expanduser(self.path + "/" + self.name + "/" + title), "wb") as f:
                    f.write(fernet.encrypt(bytes(data, 'UTF-8')))
                    return True
            except:
                pymsgbox.alert("Unable to Save Password!")
                return False
    
    @Slot(result=list)
    def fetch_passwords(self):
        files = os.listdir(os.path.expanduser(self.path + "/" + self.name.lower()))
        files.pop(files.index("pswd"))
        files.sort()
        return files

    @Slot(str, result=str)
    def view_password(self, title):
        with open(os.path.expanduser(self.path + "/" + self.name + "/" + title), "rb") as f:
            data = f.read()

        key = hashlib.sha256(self.key.encode()).digest()
        fernet = Fernet(base64.urlsafe_b64encode(key))
        new_data = fernet.decrypt(data)
        return new_data.decode('UTF-8')
    
    @Slot(str, result=bool)
    def delete_password(self, title):
        reply = pymsgbox.confirm(f"Are you sure you want to delete the Password for {title}?")
        if reply == "OK":
            os.remove(os.path.expanduser(self.path + "/" + self.name + "/" + title))
            return True
        return False

    @Slot(str, str)
    def resave_password(self, title, data):
        if data.strip() != "":
            try:
                key = hashlib.sha256(self.key.encode()).digest()
                fernet = Fernet(base64.urlsafe_b64encode(key))
                with open(os.path.expanduser(self.path + "/" + self.name + "/" + title), "wb") as f:
                    f.write(fernet.encrypt(bytes(data, 'UTF-8')))
            except:
                pymsgbox.alert("Unable to Save Password!")


app = QApplication(sys.argv)
page = QQmlApplicationEngine()

link = backend()
page.rootContext().setContextProperty("link", link)
page.quit.connect(app.quit)
page.load("src/main.qml")

sys.exit(app.exec())
