tool

extends Node

signal open_script
signal select_node(node)

var editor = preload("res://addons/Behave/Editor/Scenes/BehaviorTreeEditor.tscn")
var editor_instance = null
var node_id = -1
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

func _enter_tree():
	node_id = OS.get_ticks_msec()
	if not editor_instance:
		editor_instance = editor.instance()
	editor_instance.connect("node_connected", self, "_on_behavior_node_connected")
	editor_instance.connect("node_position_changed", self, "_on_behavior_node_pos_changed")
	editor_instance.connect("node_double_clicked", self, "_on_action_double_clicked")
	editor_instance.connect("enter_tree", self, "_on_editor_enter_tree")
	editor_instance.connect("node_selected", self, "_on_select_node")
	editor_instance.get_node("RootNode").node_model = self # MELHORAR ISSO

func _process(delta):
	if first_tick:
		child.on_enter()
	else:
		for t in tickable_tasks:
			t.tick(context)
	pass

func add_node(parent, new_node, position, params = null):
	new_node.connect("enter_tree", self, "_on_new_node_enter_tree", [new_node, parent, position])
	var root = get_tree().get_edited_scene_root()
	parent.add_child(new_node)
	new_node.set_owner(root)
#	new_node.connect("exit_tree", self, "_on_node_exit_tree", [new_node])
	

func _on_select_node(node):
	emit_signal("select_node", node)

func _on_new_node_enter_tree(new_node, parent, position):
	if position != -1: # MELHORAR ISSO AQUI
		parent.move_child(new_node, position)
		new_node.position = position
	
func _on_action_double_clicked(action_script):
	emit_signal("open_script", action_script)

func _on_behavior_node_connected(from, to, node_position):
	if to.node_model != null:
		self.add_node(from.node_model, to.node_model, node_position)
	else:
		to.connect("lazy_model_initialized", self, "_on_lazy_model_initialized", [from, to, node_position])

func _on_lazy_model_initialized(from, to, node_position):
	self.add_node(from.node_model, to.node_model, node_position)

func _on_behavior_node_pos_changed(node, position):
	if node.position != position:
		node.get_parent().move_child(node, position)
		node.position = position
	
func _on_editor_enter_tree():
	if not editor_instance.initialized:
		init_editor(self, editor_instance.get_node("RootNode"))

func init_editor(parent, parent_view):
	for child in parent.get_children():
		var node_view  = child.create_view()
		editor_instance.add_child(node_view)
		editor_instance.on_connect_request(parent_view.get_name(), 0, node_view.get_name(), 0, false)
		init_editor(child, node_view)
	editor_instance.initialized = true
	
