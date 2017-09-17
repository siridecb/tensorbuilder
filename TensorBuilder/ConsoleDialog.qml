import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

MyDialog {
	id: console_dialog
	modal: true
	
	title: {
		return is_running ? qsTr("Running...") : qsTr("Completed")
	}
	
	standardButtons: {
		return is_running ? 0 : Dialog.Ok
	}
	
	property bool is_running: false

	onAccepted: {
		
	}
	
	onRejected: function (event) {
		
	}
	
	width: 500
	height: parent.height * 0.75
	
	property var node
	property int index
	
	Rectangle {
		anchors.fill: parent
		color: '#dddddd'
		
		ScrollView {
			anchors.fill: parent
			anchors.margins: 10
			clip: true
		
			TextArea {
				id: text_area
				text: ""
				selectByKeyboard: true
				selectByMouse: true
				readOnly: true
			}
		}
	}
	
	function clear() {
		is_running = Native.is_python_running()
		text_area.clear()
	}
	
	Timer {
		interval: 100
		running: true
		repeat: true
		onTriggered: {
			is_running = Native.is_python_running()
			var stream = Native.get_python_stream()
			if (stream.length > 0) {
				text_area.text += stream
			}
		}
	}
	
	Rectangle {
		anchors.fill: parent
		color: 'transparent'
		border.width: 2
		border.color: '#a0a0a0'
	}
}
