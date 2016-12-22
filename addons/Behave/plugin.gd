tool

extends EditorPlugin

var BehaviorTree = preload("res://addons/Behave/Scripts/behavior_tree.gd")
var editor = preload("res://addons/Behave/Editor/Scenes/BehaviorTreeEditor.tscn")
var editor_instance
var script_editor


func _enter_tree():
	add_custom_type("BehaviorTree", "Node", preload("res://addons/Behave/Scripts/behavior_tree.gd"),  preload("res://addons/Behave/behv_root_icon.png"))
	editor_instance = editor.instance()
	
	script_editor =find_script_editor()


func _exit_tree():
	remove_control_from_bottom_panel(editor_instance)
	remove_custom_type("BehaviorTree")
	queue_free()

func handles(object):
	return object extends BehaviorTree

func make_visible(visible):
	if visible:
		get_viewport().get_child(0).edit_resource(load("res://addons/Behave/Editor/Scripts/utils.gd"))
		add_control_to_bottom_panel(editor_instance, "Behave")
	else:
		remove_control_from_bottom_panel(editor_instance)
	

func find_script_editor():
	var editor = get_editor_viewport()
	for i in ["ScriptEditor", "HSplitContainer", "TabContainer"]: editor = find_node(editor, i)
	return editor
	
func find_node(node, type): # Node, String
	if node != null: for i in node.get_children(): if i.get_type() == type: return i