extends PanelContainer
class_name UserMessage

signal doneTyping(message)

@export var label : Label

@export var timer : Timer

var currentMessage = ""
var currentIndex = 0

func _enter_tree() -> void:
	timer.timeout.connect(TypeEffect)
	label.text = ""

func StartTyping(message):
	currentMessage = message
	currentIndex = 0
	timer.start()

func TypeEffect():
	label.text += currentMessage[currentIndex]
	
	currentIndex += 1
	if (currentIndex >= currentMessage.length()):
		timer.stop()
		doneTyping.emit(currentMessage)
