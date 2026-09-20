extends HBoxContainer
class_name PanaMessage

signal doneTyping()

@export var label : Label

@export var thinkTimer : Timer
@export var typeTimer : Timer

@export var maxThinkTime = 5

var thinkDots = 1

var currentMessage = ""
var currentIndex = 0

func _enter_tree() -> void:
	thinkTimer.timeout.connect(ThinkEffect)
	typeTimer.timeout.connect(TypeEffect)
	
	label.text = ""

func StartTyping(message):
	currentMessage = message
	Think()

func Think():
	var thinkTime
	if (currentMessage == "Moo."):
		thinkTime = 20
	else:
		thinkTime = randf_range(0.5, maxThinkTime)
	thinkTimer.start()
	await get_tree().create_timer(thinkTime).timeout
	thinkTimer.stop()
	
	TypeMessage()

func TypeMessage():
	currentIndex = 0
	label.text = ""
	typeTimer.start()

func ThinkEffect():
	label.text = "Thinking"
	for i in range(thinkDots):
		label.text += "."
	thinkDots += 1
	if (thinkDots > 3):
		thinkDots = 1
func TypeEffect():
	label.text += currentMessage[currentIndex]
	
	currentIndex += 1
	if (currentIndex >= currentMessage.length()):
		typeTimer.stop()
		doneTyping.emit()
