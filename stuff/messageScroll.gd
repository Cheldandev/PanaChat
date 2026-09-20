extends ScrollContainer

var vScroll
var tweening = false

@export var chatManager : ChatManager

func _ready() -> void:
	vScroll = get_v_scroll_bar()

func _process(delta: float) -> void:
	if (!chatManager.messaging): return
	
	if (scroll_vertical != vScroll.max_value and tweening == false):
		scrollToBottom()
		tweening = true

func scrollToBottom():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scroll_vertical", vScroll.max_value, 0.5)
	tween.tween_callback(tweenCallback)

func tweenCallback():
	tweening = false
