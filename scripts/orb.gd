extends Area2D

var activated := false

func _on_body_entered(body: Node2D) -> void:
	if activated:
		return

	if body is CharacterBody2D:
		activated = true

		print("ORB TOUCHED - STOPPING TIMER")
		GameData.timer_running = false
