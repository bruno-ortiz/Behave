tool

extends GraphEdit

onready var popup = get_node("TreeNodeSelector")

func _ready():
	connect("connection_request", self, "_on_connect_request")
	connect("connection_to_empty", self, "_on_connect_to_empty")
	popup.connect("tree_node_selected", self, "_on_node_selected")
	
func  _on_connect_request(from, from_slot, to, to_slot):
	self.connect_node(from, from_slot, to, to_slot)
	
func _on_connect_to_empty(from, from_slot, release_position):
	popup.set_pos(release_position)
	popup.popup()
