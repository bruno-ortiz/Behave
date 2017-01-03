tool

extends GraphNode

var utils = preload("res://addons/Behave/Editor/Scripts/utils.gd") 

var node_model = null setget set_model,get_model

func _enter_tree():
	var model = get_model()
	if model == null:
		model = utils.create_new_behavior_node(get_behavior_name(), get_model_type(), null)
		set_model(model)
		model.set_pos(get_offset())
	model.connect("exit_tree", self, "_on_model_exit_tree")
	connect("offset_changed", self, "_on_offset_changed")

func _on_offset_changed():
	get_model().set_pos(get_offset())

func get_model_type():
	pass

func get_behavior_name():
	pass


func set_model(model):
	node_model = weakref(model)

func get_model():
	if node_model == null:
		return null
	return node_model.get_ref()
	
func _on_model_exit_tree():
	queue_free()