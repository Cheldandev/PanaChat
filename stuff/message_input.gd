extends Node
class_name MessageInput

signal messageSent(message)

@export var textEdit : TextEdit
@export var sendButton : Button

func _enter_tree() -> void:
	sendButton.button_down.connect(sendMessage)

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("enter") and !sendButton.disabled):
		if (!Input.is_action_pressed("shift")):
			sendMessage()

func sendMessage():
	if (textEdit.text.is_empty()):
		return
	
	messageSent.emit(textEdit.text)
	textEdit.text = ""

func enable():
	sendButton.disabled = false
func disable():
	sendButton.disabled = true
