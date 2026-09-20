extends Node
class_name MessageInput

signal messageSent(message)

@export var textEdit : TextEdit
@export var sendButton : Button

func _enter_tree() -> void:
	sendButton.button_down.connect(sendMessage)

func sendMessage():
	if (textEdit.text.is_empty()):
		return
	
	messageSent.emit(textEdit.text)
	textEdit.text = ""

func enable():
	sendButton.disabled = false
func disable():
	sendButton.disabled = true
