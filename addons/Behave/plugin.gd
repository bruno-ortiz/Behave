tool

extends EditorPlugin

var BehaviorTree = preload("res://addons/Behave/Scripts/behavior_tree.gd")
var editor = preload("res://addons/Behave/Editor/Scenes/BehaviorTreeEditor.tscn")
var added_to_panel = false
var editor_instance

func _enter_tree():
	add_custom_type("BehaviorTree", "Node", preload("res://addons/Behave/Scripts/behavior_tree.gd"),  preload("res://addons/Behave/behv_root_icon.png"))
	
	editor_instance = editor.instance()
	get_selection().connect("selection_changed", self, "_on_node_selection_changed")
	

func _exit_tree():
	remove_custom_type("BehaviorTree")
	remove_control_from_bottom_panel(editor_instance)
	queue_free()

func _on_node_selection_changed():
	var nodes = get_selection().get_selected_nodes()
	for n in nodes:
		if n extends BehaviorTree:
			if not added_to_panel:
				added_to_panel = true
				add_control_to_bottom_panel(editor_instance, "Behave")
			return
	remove_control_from_bottom_panel(editor_instance)
	added_to_panel = false
	