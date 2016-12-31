tool

extends GraphEdit

signal node_double_clicked(action_script)
signal node_connected(from, to, to_position)

var ActionNode = preload("res://addons/Behave/Editor/Scripts/Action/action_node_editor.gd")

onready var selector_popup = get_node("TreeNodeSelector")
onready var root = get_node("RootNode")

var last_popup_position = Vector2()
var last_from = null
var last_from_slot = null

func _ready():
	root.set_offset(Vector2(100, 100))
	connect("connection_request", self, "_on_connect_request")
	connect("connection_to_empty", self, "_on_connect_to_empty")
	connect("popup_request", self, "_on_popup_request")
	selector_popup.connect("tree_node_selected", self, "_on_node_selected")
	
	
func  _on_connect_request(from, from_slot, to, to_slot):
	self.connect_node(from, from_slot, to, to_slot)
	var connecting_node = get_node(to)
	var node_position = _get_node_position_in_group(connecting_node, from)
	#	NAO ESQUECER QUE AO DESCONECTAR, PRECISA REMOVER DO GRUPO
	connecting_node.add_to_group(from)
	emit_signal("node_connected", get_node(from), connecting_node, node_position)
#	var cl = get_connection_list()
#	for c in cl:
#		print(c["from"], "   " ,c["to"])
	
	
func _on_connect_to_empty(from, from_slot, release_position):
	selector_popup.set_pos(get_global_pos() + release_position)
	last_popup_position = release_position
	last_from = from
	last_from_slot = from_slot
	selector_popup.popup()

func _on_popup_request(position):
	selector_popup.set_pos(position)
	last_popup_position = position - get_global_pos()
	last_from = null
	last_from_slot = null
	selector_popup.popup()
	
func _on_node_selected(node):
	var instance = node.instance()
	selector_popup.hide()
	instance.set_offset(last_popup_position)
	if instance extends ActionNode:
		instance.connect("node_double_clicked", self, "_on_action_double_clicked")
	add_child(instance)
	if last_from != null and last_from_slot != null:
		self._on_connect_request(last_from, last_from_slot, instance.get_name(), 0)
	
	
func _on_action_double_clicked(action_script):
	emit_signal("node_double_clicked", action_script)
	
func _get_node_position_in_group(node, group):
	var nodes = get_tree().get_nodes_in_group(group)
	var position = 0
	var offset = node.get_offset()
	for n in nodes:
		if n.get_offset().y <= offset.y:
			position = position + 1
	return position
