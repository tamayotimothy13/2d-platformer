extends CanvasLayer

@onready var quit_confirm = $Control/quitConfirm
@onready var quit_button = $Control/quitButton
@onready var pause_label = $Control/pauseLabel

func _ready() -> void:
	hide()
	quit_confirm.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		print("ESC PRESSED")
		toggle_pause()

func toggle_pause() -> void:
	var is_paused = not get_tree().paused
	
	get_tree().paused = is_paused
	visible = is_paused
	
	GameData.timer_running = not is_paused
	
func _on_button_pressed() -> void:
	pause_label.hide()
	quit_button.hide()
	quit_confirm.show()

func _on_yes_pressed() -> void:
	get_tree().quit()
	
func _on_no_pressed() -> void:
	pause_label.show()
	quit_button.show()
	quit_confirm.hide()
