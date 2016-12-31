tool

extends EditorPlugin

var node_types = preload("res://addons/Behave/Scripts/node_types.gd").new()
var utils = preload("res://addons/Behave/Editor/Scripts/utils.gd").new()
var BehaviorTree = preload("res://addons/Behave/Scripts/behavior_tree.gd")
var editor = preload("res://addons/Behave/Editor/Scenes/BehaviorTreeEditor.tscn")
var editor_instance
var current_tree = null
var bottom_button = null


func _enter_tree():
	add_custom_type("BehaviorTree", "Node", preload("res://addons/Behave/Scripts/behavior_tree.gd"),  preload("res://addons/Behave/behv_root_icon.png"))
	editor_instance = editor.instance()
	editor_instance.connect("node_connected", self, "_on_behavior_node_connected")
	editor_instance.connect("node_double_clicked", self, "_on_action_double_clicked")

func _exit_tree():
	remove_control_from_bottom_panel(editor_instance)
	remove_custom_type("BehaviorTree")
	queue_free()

func handles(object):
	if object extends BehaviorTree:
		current_tree = object
		editor_instance.get_node("RootNode").node_model = current_tree
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

func _on_action_double_clicked(action_script):
	edit_resource(load(action_script))

func _on_behavior_node_connected(from, to, node_position):
	var new_node = node_types.create_new_node(to.get_behavior_type(), {})
	to.node_id = new_node.node_id
	current_tree.add_node(from.node_id, new_node, node_position)
