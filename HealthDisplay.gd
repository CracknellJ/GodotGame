extends Node2D

# Health bar loads
var bar_red = preload("res://GodotBars/barHorizontal_green.png")
var bar_green = preload("res://GodotBars/barHorizontal_green.png")
var bar_yellow = preload("res://GodotBars/barHorizontal_yellow.png")
# Creates a reference to the health bar
onready var healthbar = $HealthBar

# Function for displaying health. Starts the bar hidden. Comment out hide() to remove
func _ready():
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health 

# Prevents the bar from rotating so it's always above the sprite
func _process(delta):
	global_rotation = 0;

# Function to call when the value of the health bar changes 
func update_healthbar(value):
	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 3.5:
		healthbar.texture_progress = bar_red
	if value < healthbar.max_value:
		show()
		healthbar.value = value