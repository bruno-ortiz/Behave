tool

extends EditorPlugin

var BehaviorTree = preload("res://addons/Behave/Scripts/behavior_tree.gd")
var current_tree = null
var bottom_button = null
var editor_instance = null


func _enter_tree():
	add_custom_type("BehaviorTree", "Node", preload("res://addons/Behave/Scripts/behavior_tree.gd"),  preload("res://addons/Behave/behv_root_icon.png"))

func _exit_tree():
	remove_control_from_bottom_panel(editor_instance)
	remove_custom_type("BehaviorTree")
	queue_free()

func handles(object):
	if object extends BehaviorTree:
		current_tree = object
		editor_instance = current_tree.editor_instance
		if not current_tree.is_connected("open_script", self, "_open_script"):
			current_tree.connect("open_script", self, "_open_script")
		return true
	return false

func make_visible(visible):
	if visible:
		if not bottom_button:
			bottom_button = add_control_to_bottom_panel(editor_instance, "Behave")
		bottom_button.show()
	else:
		bottom_button.set_pressed(false)
		bottom_button.hide()
		editor_instance.hide()

func _open_script(action_script):
	edit_resource(load(action_script))
	
