import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

Page {
    id: root;

    signal connectionRequest(string bAddr, int bPort, string bUser, string bPass);

    //  UN PO DI JS

    function checkAll(){
        dialog.title = qsTr("Errore");

        if(addr.textInput.text == ""){
            dialog.text = qsTr("L'indirizzo non può essere vuoto.");
            dialog.open();
            addr.textInput.focus = true;
            return false;
        }
        if(port.textInput.text == ""){
            dialog.text = qsTr("La porta non può essere vuota.");
            dialog.open();
            port.textInput.focus = true;
            return false;
        }
        if(user.textInput.text == ""){
            dialog.text = qsTr("L'username non può essere vuoto.");
            dialog.open();
            user.textInput.focus = true;
            return false;
        }
        if(pass.textInput.text == ""){
            dialog.text = qsTr("La password non può essere vuota.");
            dialog.open();
            pass.textInput.focus = true;
            return false;
        }
        return true;
    }

    function clearAll(){
        addr.textInput.text = "";
        port.textInput.text = "";
        user.textInput.text = "";
        pass.textInput.text = "";
    }

    function checkPwd(){
        var pattern = /^([a-z]||[A-Z]||[0-9])+$/
        if(!pattern.test(pass.textInput.text)){
            dialog.title = qsTr("Errore");
            dialog.text = qsTr("La password può contenere solo caratteri e numeri");
            dialog.open();
            pass.textInput.text = "";
            pass.textInput.forceActiveFocus();
        }
    }

    //  FRAME RETE

    Row{
        id: networkHeader
        spacing: 15
        anchors{
            top: parent.top
            left: parent.left
            topMargin: 45
            leftMargin: 15
        }
        Image {
            width: 30
            height: 30
            source: "ico/icons/net-48.png"
        }

        Label{
            width: root.width / 2
            text: qsTr("Rete");
            font.pixelSize: 25
        }
    }

    Grid{
        id: networkFrame
        anchors{
            top: networkHeader.bottom
            topMargin: 15
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 8
        columns: 2

        Label{
            width: root.width / 3
            height: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("IP o Dominio");
        }

        MTextInput{
            id: addr
            width: root.width / 2
            height: 30
            //textInput.text: qsTr("danilom93.homepc.it");
            textInput.text: qsTr("192.168.1.41");
            textInput.validator: RegExpValidator{
                                    regExp: /^(([a-z]||[A-Z]||[0-9])+[.])+$/
                                 }
        }

        Label{
            width: root.width / 3
            height: 30
            text: qsTr("Porta");
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MTextInput{
            id: port
            width: root.width / 2
            height: 30
            textInput.text: qsTr("8000");
            textInput.validator: RegExpValidator{
                                    regExp: /^(?:6553[0-5]|655[0-2][0-9]|65[0-4][0-9]{2}|6[0-4][0-9]{3}|[1-5][0-9]{4}|[1-9][0-9]{1,3}|[1-9])$/
                                 }
        }

        Label{
            id: rememberNetLabel
            width: root.width / 3
            height: 30
            text: qsTr("Ricorda");
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Switch{
            id: rememberNet
            height: 30
            checked: true
            style:  SwitchStyle {
                        groove: Rectangle {
                                    implicitWidth: 75
                                    implicitHeight: 20
                                    radius: 9
                                    border.color: "LightSlateGrey"
                                    border.width: 1
                                }
                        handle: Rectangle {
                                    implicitWidth: 25
                                    implicitHeight: 25
                                    radius: 25
                                    color: "SlateGray"
                                    border.color: "LightSlateGrey"
                                    border.width: 1
                                }
                    }
            onCheckedChanged:   {
                                    if(checked){
                                        rememberNetLabel.text = qsTr("Ricorda");
                                    }else{
                                        rememberNetLabel.text = qsTr("Non ricordare");
                                    }
                                }
        }
    }

    //  FRAME UTENTE

    Row{
        id: userHeader
        spacing: 15
        anchors{
            top: networkFrame.bottom
            topMargin: 15
            left: parent.left
            leftMargin: 15
        }

        Image {
            source: "ico/icons/contacts-50.png"
            height: 30
            width: 30
        }

        Label{
            width: root.width / 2
            text: qsTr("Utente");
            font.pixelSize: 25
        }
    }

    Grid{
        id: userFrame
        anchors{
            top: userHeader.bottom
            topMargin: 15
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 8
        columns: 2

        Label{
            width: root.width / 3
            height: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Username");
        }

        MTextInput{
            id: user
            width: root.width / 2
            height: 30
            textInput.text: qsTr("admin");
            textInput.validator: RegExpValidator{
                                    regExp: /^([a-z]||[A-Z]||[0-9])+$/
                                 }
        }

        Label{
            width: root.width / 3
            height: 30
            text: qsTr("password");
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MTextInput{
            id: pass
            width: root.width / 2
            height: 30
            textInput.text: qsTr("admin");
            textInput.echoMode: TextInput.Password;
            textInput.onTextChanged: {
                                        checkPwd();
                                     }
        }

        Label{
            id: rememberUsrLabel
            width: root.width / 3
            height: 30
            text: qsTr("Ricorda");
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Switch{
            id: rememberUsr
            height: 30
            checked: true
            style:  SwitchStyle {
                        groove: Rectangle {
                                    implicitWidth: 75
                                    implicitHeight: 20
                                    radius: 9
                                    border.color: "LightSlateGrey"
                                    border.width: 1
                                }
                        handle: Rectangle {
                                    implicitWidth: 25
                                    implicitHeight: 25
                                    radius: 25
                                    color: "SlateGray"
                                    border.color: "LightSlateGrey"
                                    border.width: 1
                                }
                    }
            onCheckedChanged:   {
                                    if(checked){
                                        rememberUsrLabel.text = qsTr("Ricorda");
                                    }else{
                                        rememberUsrLabel.text = qsTr("Non ricordare");
                                    }
                                }
        }
    }

    //  BOTTONI

    Row{
        spacing: 15
        anchors{
            top: userFrame.bottom
            topMargin: 15
            horizontalCenter: parent.horizontalCenter
        }

        MButton{
            id: loginButton
            height: 30
            width: 75
            text: qsTr("Login");
            onClicked: {
                            if(checkAll()){
                                root.connectionRequest(addr.textInput.text,
                                                       parseInt(port.textInput.text.toString()),
                                                       user.textInput.text,
                                                       pass.textInput.text);
                            }
                       }
        }

        MButton{
            id: cancelButton
            height: 30
            width: 75
            text: qsTr("Cancella");
            onClicked: {
                clearAll();
            }
        }
    }

    // MESSAGE BOX
    MessageDialog{
        id: dialog
        standardButtons: StandardButton.Ok;
    }
}
