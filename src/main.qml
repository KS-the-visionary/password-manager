import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import "."

Window {
    width: 860; height: 600
    color: "#00000000"
    visible: true
    id: win
    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle {
        width: 800; height: 533.33
        color: "#1A1A1A"
        radius: 40
        anchors.centerIn: parent
        id: body
        clip: true
        // Main Body of the app
        // Custom Styling. Hence the actual window drawn by the compositor is hidden

        FontLoader {
            id: customFont
            source: "assets/Inter-Bold.ttf"
        }

        //Custom Title Bar
        Rectangle {
            width: 800; height: 80
            radius: 40
            anchors.top: parent.top
            anchors.left: parent.left
            color: "#00000000"
            z: 0
            DragHandler {
                onActiveChanged: if (active==true) {win.startSystemMove()}
            }


        
            // Close Button
            Rectangle{
                width: 20; height: 20
                radius: 10
                color: "#EC5C76"
                anchors {top:parent.top; right: parent.right; topMargin: 26.67; rightMargin: 30.67}
                z: 1
                Image {
                    source: "assets/close.png"
                    anchors.centerIn: parent
                    opacity: close_btn.containsMouse ? 1 : 0
                    Behavior on opacity { NumberAnimation { duration: 100 } }
                }

                MouseArea{
                    anchors.fill: parent
                    id: close_btn
                    hoverEnabled: true
                    onClicked: win.close()
                }
            }
            //Minimise Button
            Rectangle{
                width: 20; height: 20
                radius: 10
                color: "#C9C941"
                anchors {top:parent.top; right: parent.right; topMargin: 26.67; rightMargin: 70.67}
                z: 1
                Image {
                    source: "assets/min.png"
                    anchors.centerIn: parent
                    opacity: min_btn.containsMouse ? 1 : 0
                    Behavior on opacity { NumberAnimation { duration: 100 } }
                }

                MouseArea{
                    anchors.fill: parent
                    id: min_btn
                    hoverEnabled: true
                    onClicked: win.showMinimized()
                }
            }
        }

        // Using a StackView to control the navigation of multiple pages throughout the application
        StackView {
            id: stack
            anchors.fill: parent
            initialItem: home_page

            // Home Page. Appears First on Startup
            Component {
                id: home_page
                Item{
                    width: 800; height: 533.33

                    Image {
                        source: "assets/welcome.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:205.33; topMargin:52}

                    }

                    Image {
                        source: "assets/users.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:138.67; topMargin:200}
                    }

                    Image {
                        source: "assets/adduser.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:529.33; topMargin:200}
                    }

                    // "Login" Button
                    Rectangle {
                        width: 172; height: 53.33
                        radius: 13.33
                        anchors {top:parent.top; left:parent.left; leftMargin:118.67; topMargin:386.67}
                        color: login_btn.containsMouse ? "#EC5C76" : "#363536"
                        Behavior on color { PropertyAnimation { duration: 150 } }

                        Image {
                            source: "assets/logintext.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: login_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                        }

                    }

                    // "Signup" Button
                    Rectangle {
                        width: 172; height: 53.33
                        radius: 13.33
                        anchors {top:parent.top; left:parent.left; leftMargin:509.33; topMargin:386.67}
                        color: signin_btn.containsMouse ? "#41c95a" : "#363536"
                        Behavior on color { PropertyAnimation { duration: 150 } }

                        Image {
                            source: "assets/singuptext.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: signin_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: stack.push(signup_page)
                        }

                    }
                }
            }

            // User Signup Page
            Component {
                id: signup_page

                Item {
                    width: 800; height: 533.33

                    Image {
                        source: "assets/signuptitle.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:308; topMargin:10}
                    }

                    Image {
                        source: "assets/addusericon.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:340; topMargin:83}
                    }

                    Image {
                        source: "assets/usrname.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:260; topMargin:229}
                    }

                    Image {
                        source: "assets/pswd.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:271; topMargin:289}
                    }

                    Image {
                        source: "assets/cpswd.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:187; topMargin:349}
                    }

                    // UserName Text Field
                    Rectangle {
                        width: 161; height:40
                        radius: 10
                        color: "#373537"
                        anchors {top:parent.top; left:parent.left; leftMargin:378; topMargin:221}
                        clip: true

                        TextEdit {
                            id: usrname_s
                            anchors.fill: parent
                            font { family: customFont.name; pixelSize: 20 }
                            color: "#ffffff"
                            verticalAlignment: TextInput.AlignVCenter
                            horizontalAlignment: TextInput.AlignHCenter
                        }
                    }

                    // Password Text Field
                    Rectangle {
                        width: 161; height:40
                        radius: 10
                        color: "#373537"
                        anchors {top:parent.top; left:parent.left; leftMargin:378; topMargin:281}
                        clip: true

                        TextEdit {
                            id: pswd_s
                            anchors.fill: parent
                            font { family: customFont.name; pixelSize: 20 }
                            color: "#ffffff"
                            verticalAlignment: TextInput.AlignVCenter
                            horizontalAlignment: TextInput.AlignHCenter
                            inputMethodHints: Qt.ImhHiddenText | Qt.ImhSensitiveData
                        }
                    }

                    // Confirm Password Text Field
                    Rectangle {
                        width: 161; height:40
                        radius: 10
                        color: "#373537"
                        anchors {top:parent.top; left:parent.left; leftMargin:378; topMargin:341}
                        clip: true

                        TextEdit {
                            id: cpswd_s
                            anchors.fill: parent
                            font { family: customFont.name; pixelSize: 20 }
                            color: "#ffffff"
                            verticalAlignment: TextInput.AlignVCenter
                            horizontalAlignment: TextInput.AlignHCenter
                            inputMethodHints: Qt.ImhHiddenText | Qt.ImhSensitiveData
                        }
                    }

                    // "Add User" Button. Calls Python Function to add a User
                    Rectangle {
                        width: 172; height: 53.33
                        radius: 13.33
                        anchors {top:parent.top; left:parent.left; leftMargin:314; topMargin:422}
                        color: add_user_btn.containsMouse ? "#41c984" : "#41c94c"
                        Behavior on color { PropertyAnimation { duration: 150 } }

                        Image {
                            source: "assets/adduserbtntext.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: add_user_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: link.add_new_user(usrname_s.text, pswd_s.text, cpswd_s.text)
                        }
                    }


                    // "Go Back" Button
                    Rectangle {
                        width: 40; height: 40
                        radius: 10
                        anchors {top:parent.top; left:parent.left; leftMargin:20; topMargin:20}
                        color: goback_btn.containsMouse ? "#5a5c5a" : "#373537"
                        Behavior on color { PropertyAnimation { duration: 150 } }
                        z: 1
                        Image {
                            source: "assets/gobackicon.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: goback_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: stack.pop()
                        }
                    }

                }
            }
        }

    }

    RectangularGlow {
        anchors.fill: body
        color: "#000000"
        spread: 0.1
        glowRadius: 25
        cornerRadius: 30
        z: -1
    }

    Connections {
        target: link
    }
}
