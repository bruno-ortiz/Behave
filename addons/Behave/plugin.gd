tool

extends EditorPlugin

var BehaviorTree = preload("res://addons/Behave/Scripts/behavior_tree.gd")
var editor = preload("res://addons/Behave/Editor/Scenes/BehaviorTreeEditor.tscn")
var editor_instance
var script_editor


func _enter_tree():
	add_custom_type("BehaviorTree", "Node", preload("res://addons/Behave/Scripts/behavior_tree.gd"),  preload("res://addons/Behave/behv_root_icon.png"))
	editor_instance = editor.instance()

func _exit_tree():
	remove_control_from_bottom_panel(editor_instance)
	remove_custom_type("BehaviorTree")
	queue_free()

func handles(object):
#edit_resource(load("res://addons/Behave/Editor/Scripts/utils.gd"))	
	return object extends BehaviorTree

func make_visible(visible):
	if visible:
		add_control_to_bottom_panel(editor_instance, "Behave")
	else:
		remove_control_from_bottom_panel(editor_instance)
