extends Control

@export var game_scene: PackedScene

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		get_tree().change_scene_to_packed(game_scene)
