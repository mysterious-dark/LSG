extends Control

signal transition_completed

# Scene paths - adjust these to match your actual scene paths
const HUB_SCENE = "res://1_MainPhases/Hub/hub.tscn"

@export var NEXT_SCENE = ""

@onready var progress_bar = $CenterContainer/VBoxContainer/ProgressBar
@onready var status_label = $CenterContainer/VBoxContainer/StatusLabel

func _ready():
	# Start the loading process
	progress_bar.value = 0

func start_loading_sequence():
	# Create a tween for smooth progress bar animation
	var tween = create_tween()
	tween.tween_property(progress_bar, "value", 30, 0.5)
	
	# Perform initial checks
	status_label.text = "Checking save data..."
	await get_tree().create_timer(0.5).timeout
	
	# Update progress
	tween = create_tween()
	tween.tween_property(progress_bar, "value", 60, 0.5)
	
	# Check if player has created a character
	status_label.text = "Checking character data..."
	var has_character = globalFunctions.check_for_character()
	await get_tree().create_timer(0.5).timeout
	
	# Final progress update
	tween = create_tween()
	tween.tween_property(progress_bar, "value", 100, 0.5)
	
	# Determine which scene to load
	status_label.text = "Preparing scene..."
	await get_tree().create_timer(0.5).timeout
	
	load_next_scene()

func load_next_scene():
	status_label.text = "Loading fight..."
	# You might want to use ResourceLoader.load_threaded() for larger scenes
	get_tree().change_scene_to_file(HUB_SCENE)
