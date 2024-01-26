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
    property string name_of_user: "user"
    property bool can_edit_pswd: false
    property var passwords: []

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
                z: 3
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
                z: 3
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
                            onClicked: stack.push(login_page)
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

                        TextInput {
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

                        TextInput {
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

                        TextInput {
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

            // User Log-in Page
            Component {
                id: login_page

                Item {
                    width: 800; height: 533.33

                    Image {
                        source: "assets/logintitle.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:326; topMargin:10}
                    }

                    Image {
                        source: "assets/usericon.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:334; topMargin:97}
                    }

                    Image {
                        source: "assets/usrname.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:260; topMargin:267}
                    }

                    Image {
                        source: "assets/pswd.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:271; topMargin:327}
                    }

                    // UserName Text Field
                    Rectangle {
                        width: 161; height:40
                        radius: 10
                        color: "#373537"
                        anchors {top:parent.top; left:parent.left; leftMargin:378; topMargin:259}
                        clip: true 

                        TextInput {
                            id: usrname_l
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
                        anchors {top:parent.top; left:parent.left; leftMargin:378; topMargin:319}
                        clip: true

                        TextInput {
                            id: pswd_l
                            anchors.fill: parent
                            font { family: customFont.name; pixelSize: 20 }
                            color: "#ffffff"
                            verticalAlignment: TextInput.AlignVCenter
                            horizontalAlignment: TextInput.AlignHCenter
                            inputMethodHints: Qt.ImhHiddenText | Qt.ImhSensitiveData
                        }
                    }

                    // "Log in" Button. Calls Python Function to check password
                    // and login to show to DashBoard
                    Rectangle {
                        width: 172; height: 53.33
                        radius: 13.33
                        anchors {top:parent.top; left:parent.left; leftMargin:314; topMargin:422}
                        color: login_to_dashboard_btn.containsMouse ? "#41c984" : "#41c94c"
                        Behavior on color { PropertyAnimation { duration: 150 } }

                        Image {
                            source: "assets/loginbtntext.png"
                            anchors.centerIn: parent
                        }


                        MouseArea{
                            anchors.fill: parent
                            id: login_to_dashboard_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: () => {
                                let is_match = link.log_in(usrname_l.text, pswd_l.text);
                                if (is_match == true) {
                                    stack.push(dashboard_page)
                                    usrname_l.clear();
                                    pswd_l.clear();
                                }
                            }
                        }
                    }


                    // "Go Back" Button
                    Rectangle {
                        width: 40; height: 40
                        radius: 10
                        anchors {top:parent.top; left:parent.left; leftMargin:20; topMargin:20}
                        color: goback_btn_l.containsMouse ? "#5a5c5a" : "#373537"
                        Behavior on color { PropertyAnimation { duration: 150 } }
                        z: 1
                        Image {
                            source: "assets/gobackicon.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: goback_btn_l
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: stack.pop()
                        }
                    }

                }
            }

            // DashBoard Page. Appears only after Login
            Component {
                id: dashboard_page
                Item{
                    width: 800; height: 533.33

                    // Greeter Element. Dynamically loads user name for each user
                    Rectangle {
                        width: 800; height: 61
                        anchors { top: parent.top; topMargin: 40 }
                        color: "#00000000"

                        Text{
                            color: "#ffffff"
                            anchors.fill: parent
                            text: "Welcome, " + name_of_user + "!"
                            font { family: customFont.name; pixelSize: 40}
                            horizontalAlignment: TextArea.AlignHCenter
                            verticalAlignment: TextArea.AlignVCenter
                        }
                    }

                    Image {
                        source: "assets/viewpswdicon.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:135; topMargin:157}
                    }

                    Image {
                        source: "assets/savepswdicon.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:534; topMargin:167}
                    }

                    // Button to let user view saved passwords Button
                    Rectangle {
                        width: 241; height: 53
                        radius: 13.33
                        anchors {top:parent.top; left:parent.left; leftMargin:85; topMargin:396}
                        color: view_pswds_btn.containsMouse ? "#EC5C76" : "#363536"
                        Behavior on color { PropertyAnimation { duration: 150 } }

                        Image {
                            source: "assets/viewpswdsbtntext.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: view_pswds_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: () => { passwords=link.fetch_passwords(); stack.push(view_passwords_page) }
                        }

                    }

                    // Button to let user save new passwords
                    Rectangle {
                        width: 241; height: 53
                        radius: 13.33
                        anchors {top:parent.top; left:parent.left; leftMargin:474; topMargin:396}
                        color: save_pswds_btn.containsMouse ? "#41c95a" : "#363536"
                        Behavior on color { PropertyAnimation { duration: 150 } }

                        Image {
                            source: "assets/savepswdsbtntext.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: save_pswds_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: stack.push(save_passwords_page)
                        }

                    }

                    // "Go Back" Button. Also logs out the session and user
                    Rectangle {
                        width: 40; height: 40
                        radius: 10
                        anchors {top:parent.top; left:parent.left; leftMargin:20; topMargin:20}
                        color: goback_btn_d.containsMouse ? "#5a5c5a" : "#373537"
                        Behavior on color { PropertyAnimation { duration: 150 } }
                        z: 1
                        Image {
                            source: "assets/gobackicon.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: goback_btn_d
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: stack.pop()
                        }
                    }
                }
            }

            // Saving Passwords Page
            Component {
                id: save_passwords_page

                Item {
                    width: 800; height: 533.33

                    Image {
                        source: "assets/savepswdspagetitle.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:240; topMargin:20}
                    }

                    Image {
                        source: "assets/titleofpswd.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:292; topMargin:102}
                    }

                    // name of password Text Field
                    Rectangle {
                        width: 161; height:40
                        radius: 10
                        color: "#373537"
                        anchors {top:parent.top; left:parent.left; leftMargin:347; topMargin:94}

                        TextInput {
                            id: name_of_pswd
                            anchors.fill: parent
                            font { family: customFont.name; pixelSize: 20 }
                            color: "#ffffff"
                            verticalAlignment: TextInput.AlignVCenter
                            horizontalAlignment: TextInput.AlignHCenter
                        }
                    }

                    // details of password Text Area
                    Rectangle {
                        width: 320; height:221
                        radius: 15
                        color: "#373537"
                        anchors {top:parent.top; left:parent.left; leftMargin:240; topMargin:169}

                        TextEdit {
                            padding: 10
                            id: details_of_pswd
                            anchors.fill: parent
                            font { family: customFont.name; pixelSize: 15 }
                            color: "#ffffff"
                        }
                    }

                    //"Button to save passwords"
                    Rectangle {
                        width: 172; height: 53.33
                        radius: 13.33
                        anchors {top:parent.top; left:parent.left; leftMargin:314; topMargin:422}
                        color: save_pswd_btn.containsMouse ? "#41C955" : "#363536"
                        Behavior on color { PropertyAnimation { duration: 150 } }

                        Image {
                            source: "assets/savepswdbtntext.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: save_pswd_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: () => {
                                let saved = link.save_password(name_of_pswd.text, details_of_pswd.text);
                                if (saved) {
                                    details_of_pswd.text = "Password Saved Successfully!";
                                    name_of_pswd.clear()
                                }
                            }
                        }

                    }

                    // "Go Back" Button goes back to dashboard
                    Rectangle {
                        width: 40; height: 40
                        radius: 10
                        anchors {top:parent.top; left:parent.left; leftMargin:20; topMargin:20}
                        color: goback_btn_save_pswd_page.containsMouse ? "#5a5c5a" : "#373537"
                        Behavior on color { PropertyAnimation { duration: 150 } }
                        z: 1
                        Image {
                            source: "assets/gobackicon.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: goback_btn_save_pswd_page
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: () => {
                                stack.pop();
                                details_of_pswd.clear();
                                name_of_pswd.clear();
                            }
                        }
                    }

                }
            }

            // Viewying Passwords Page
            Component {
                id: view_passwords_page

                Item {
                    width: 800; height: 533.33

                    Image {
                        source: "assets/viewpswdspagetitle.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:238; topMargin:20}
                    }

                    Image {
                        source: "assets/choosetitleofpswd.png"
                        anchors {top:parent.top; left:parent.left; leftMargin:252; topMargin:102}
                    }

                    // name of password Text Field
                    Rectangle {
                        width: 161; height:40
                        radius: 10
                        color: "#373537"
                        anchors {top:parent.top; left:parent.left; leftMargin:387; topMargin:94}

                        ComboBox {
                            id: view_saved_passowrds
                            flat: true
                            anchors.fill: parent
                            model: passwords
                            contentItem: Text{
                                id: contents
                                color: "#ffffff"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font { family: customFont.name; pixelSize: 20 }
                                text: view_saved_passowrds.currentText
                            }
                            background:  Rectangle{
                                id: bg
                                width: 161; height: 40
                                radius: 10
                                color: "#373537"
                            }
                            popup: Popup {
                                y: bg.height
                                height: 150
                                width: bg.width
                                padding: 1

                                contentItem: ListView {
                                    clip: true
                                    implicitHeight: 150
                                    model: view_saved_passowrds.popup.visible ? view_saved_passowrds.delegateModel : null
                                    currentIndex: view_saved_passowrds.highlightedIndex
                                    ScrollIndicator.vertical: ScrollIndicator { }
                                }

                                background: Rectangle{
                                    width: bg.width; height: 150
                                    color: "#373537"
                                    radius: 10
                                    RectangularGlow {
                                        anchors.fill: parent
                                        color: "#282828"
                                        spread: 0.1
                                        glowRadius: 25
                                        cornerRadius: 30
                                        z: -1
                                    }
                                }
                            }
                        }
                    }

                    // details of password Text Area
                    Rectangle {
                        width: 320; height:221
                        radius: 15
                        color: "#373537"
                        anchors {top:parent.top; left:parent.left; leftMargin:240; topMargin:169}
                        enabled: can_edit_pswd

                        TextEdit {
                            padding: 10
                            id: view_details_of_pswd
                            anchors.fill: parent
                            font { family: customFont.name; pixelSize: 15 }
                            color: "#ffffff"
                        }
                    }

                    //"Button to View passwords"
                    Rectangle {
                        width: 172; height: 53.33
                        radius: 13.33
                        anchors {top:parent.top; left:parent.left; leftMargin:314; topMargin:422}
                        color: view_pswd_btn.containsMouse ? "#EC5C76" : "#363536"
                        Behavior on color { PropertyAnimation { duration: 150 } }

                        Image {
                            source: "assets/viewpswdbtntext.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: view_pswd_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: view_details_of_pswd.text=link.view_password(view_saved_passowrds.currentText)
                        }

                    }

                    // "Go Back" Button goes back to dashboard
                    Rectangle {
                        width: 40; height: 40
                        radius: 10
                        anchors {top:parent.top; left:parent.left; leftMargin:20; topMargin:20}
                        color: goback_btn_view_pswd_page.containsMouse ? "#5a5c5a" : "#373537"
                        Behavior on color { PropertyAnimation { duration: 150 } }
                        z: 1
                        Image {
                            source: "assets/gobackicon.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: goback_btn_view_pswd_page
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: () => {
                                stack.pop();
                                view_details_of_pswd.clear();
                            }
                        }
                    }
                    

                    // "Edit" Button
                    Rectangle {
                        width: 40; height: 40
                        radius: 10
                        anchors {top:parent.top; left:parent.left; leftMargin:604; topMargin:169}
                        color: {
                            if (can_edit_pswd==false && edit_pswd_btn.containsMouse==false) {
                                "#363536"
                            } else if (can_edit_pswd==false && edit_pswd_btn.containsMouse==true) {
                                "#3283d5"
                            } else if (can_edit_pswd==true && edit_pswd_btn.containsMouse==false) {
                                "#3283d5"
                            } else if (can_edit_pswd==true && edit_pswd_btn.containsMouse==true) {
                                "#41c9c9"
                            } else {
                                "red"
                            }
                        }
                        Behavior on color { PropertyAnimation { duration: 150 } }
                        z: 1
                        Image {
                            source: "assets/editbtnicon.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: edit_pswd_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: can_edit_pswd = !can_edit_pswd
                        }
                    }

                    // "Delete" Button
                    Rectangle {
                        width: 40; height: 40
                        radius: 10
                        anchors {top:parent.top; left:parent.left; leftMargin:604; topMargin:260}
                        color: delete_pswd_btn.containsMouse ? "#EC5C76" : "#373537"
                        Behavior on color { PropertyAnimation { duration: 150 } }
                        z: 1
                        Image {
                            source: "assets/deletebtnicon.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: delete_pswd_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: () => {
                                let val = link.delete_password(view_saved_passowrds.currentText); 
                                if (val) {
                                    passwords=link.fetch_passwords(); view_details_of_pswd.clear()
                                }
                            }
                        }
                    }

                    // "Re-Save" Button
                    Rectangle {
                        width: 40; height: 40
                        radius: 10
                        anchors {top:parent.top; left:parent.left; leftMargin:604; topMargin:350}
                        color: resave_pswd_btn.containsMouse ? "#3283d5" : "#373537"
                        Behavior on color { PropertyAnimation { duration: 150 } }
                        z: 1
                        Image {
                            source: "assets/resavebtnicon.png"
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            id: resave_pswd_btn
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: link.resave_password(view_saved_passowrds.currentText, view_details_of_pswd.text)
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