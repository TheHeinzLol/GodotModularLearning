extends CanvasLayer

@onready var label_fps = $MarginContainer/ColorRect/VBoxContainer/FPS
@onready var label_position = $MarginContainer/ColorRect/VBoxContainer/Position
@onready var label_velocity = $MarginContainer/ColorRect/VBoxContainer/Velocity
@onready var label_animation = $MarginContainer/ColorRect/VBoxContainer/Animation
@onready var player = $"../Player"

func _process(delta: float) -> void:
	label_fps.text = "FPS: %s" %Engine.get_frames_per_second()
	label_position.text = "Position: %s" %player.global_position
	label_velocity.text = "Velocity: %s" %player.velocity
	label_animation.text = "Animation: %s" %player.animations.current_animation
