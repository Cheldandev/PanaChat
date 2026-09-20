extends Node
class_name ChatManager

@export var messageInput : MessageInput
@export var panaBehavior : PanaBehavior

@export var packedUserMessage : PackedScene
@export var packedPanaMessage : PackedScene
@export var packedSeparator : PackedScene

@export var messageParent : Control

var messaging = false

func _enter_tree() -> void:
	messageInput.messageSent.connect(onMessageSent)

func onMessageSent(message):
	messageInput.disable()
	messaging = true
	
	if (messageParent.get_child_count() > 0):
		messageParent.add_child(packedSeparator.instantiate())
	
	var userMessage : UserMessage = packedUserMessage.instantiate()
	messageParent.add_child(userMessage)
	
	userMessage.StartTyping(message)
	userMessage.doneTyping.connect(getPanaResponse, CONNECT_ONE_SHOT)

func getPanaResponse(message):
	await get_tree().create_timer(1).timeout
	
	messageParent.add_child(packedSeparator.instantiate())
	
	var panaMessage : PanaMessage = packedPanaMessage.instantiate()
	messageParent.add_child(panaMessage)
	
	panaMessage.StartTyping(panaBehavior.getMessage(message))
	panaMessage.doneTyping.connect(onMessageEnd, CONNECT_ONE_SHOT)

func onMessageEnd():
	messageInput.enable()
	messaging = false
