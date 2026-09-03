extends Node2D

@onready var timer_label = $UI/TimerLabel

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart_game()

func restart_game() -> void:
	GameData.elapsed_time = 0.0
	GameData.timer_running = true

	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _ready() -> void:
	GameData.elapsed_time = 0.0
	GameData.timer_running = true


func _process(delta: float) -> void:
	if GameData.timer_running:
		GameData.elapsed_time += delta

	update_timer()

func update_timer() -> void:
	var minutes := int(GameData.elapsed_time / 60.0)
	var seconds := int(GameData.elapsed_time) % 60
	var milliseconds := int(
		(GameData.elapsed_time - floor(GameData.elapsed_time)) * 100
	)

	timer_label.text = "%02d:%02d.%02d" % [
		minutes,
		seconds,
		milliseconds
	]
