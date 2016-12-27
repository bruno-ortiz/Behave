tool

extends Node

var utils = preload("res://addons/Behave/Editor/Scripts/utils.gd").new()

var tree_model = null setget ,get_model

export(String, FILE, "*.json") var tree_file = null

var child = null
var tickable_tasks
var open_tasks

var first_tick = true

var context = {
	target = get_parent(),
	tree = self
}

func _ready():
	if not get_tree().is_editor_hint():
		set_process(true)
	# TODO: COMEÇAR A VER AONDE INSTANCIAR MODEL
	pass

func _process(delta):
	if first_tick:
		child.on_enter()
	else:
		for t in tickable_tasks:
			t.tick(context)
	pass
	

func get_model():
	if not tree_model:
		tree_model = utils.parse_json_from_file(tree_file)
	return tree_model