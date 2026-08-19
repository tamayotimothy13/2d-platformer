extends AnimatableBody2D

@export var is_crumbling := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_crumbling:
		$Sprite2D.modulate = Color(0.6, 0.6, 0.6) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_detection_area_body_entered(body: Node2D) -> void:
	if not is_crumbling:
		return
	
	if body is CharacterBody2D:
		$CrumbleTimer.start() # Replace with function body.


func _on_crumble_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$DetectionArea.set_deferred("monitoring", false)
	$Sprite2D.visible = false # Replace with function body.
	$RespawnTimer.start()


func _on_respawn_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	$DetectionArea.set_deferred("monitoring", true)
	$Sprite2D.visible = true # Replace with function body.
