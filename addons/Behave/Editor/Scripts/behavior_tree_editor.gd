tool

extends GraphEdit

onready var popup = get_node("TreeNodeSelector")
onready var root = get_node("RootNode")

var last_popup_position = Vector2()
var last_from = null
var last_from_slot = null

func _ready():
	root.set_offset(Vector2(100, 100))
	connect("connection_request", self, "_on_connect_request")
	connect("connection_to_empty", self, "_on_connect_to_empty")
	connect("popup_request", self, "_on_popup_request")
	popup.connect("tree_node_selected", self, "_on_node_selected")
	
func  _on_connect_request(from, from_slot, to, to_slot):
	self.connect_node(from, from_slot, to, to_slot)
	var cl = get_connection_list()
	for c in cl:
		print(c["from"], "   " ,c["to"])
	
	
func _on_connect_to_empty(from, from_slot, release_position):
	popup.set_pos(get_global_pos() + release_position)
	last_popup_position = release_position
	last_from = from
	last_from_slot = from_slot
	popup.popup()

func _on_popup_request(position):
	popup.set_pos(position)
	last_popup_position = position - get_global_pos()
	last_from = null
	last_from_slot = null
	popup.popup()
	
func _on_node_selected(node):
	var instance = node.instance()
	popup.hide()
	instance.set_offset(last_popup_position)
	add_child(instance)
	if last_from != null and last_from_slot != null:
		self._on_connect_request(last_from, last_from_slot, instance.get_name(), 0)
	