tool

extends "res://addons/Behave/Editor/Scripts/base_behavior_node_view.gd"

var current_file = ""
var current_file_name = ""
var action_popup = null
onready var creation_popup = preload("res://addons/Behave/Editor/Scenes/CreateActionDialog.tscn")

signal node_double_clicked(action_script)
signal lazy_model_initialized

func _ready():
	print("Action Node ready!")
	action_popup = creation_popup.instance()
	action_popup.connect("popup_hide", self, "_on_choose_action_script")
	print("Parent name: ",get_node("..").get_name())
	get_node("..").add_child(action_popup)
	action_popup.popup_centered()
	connect("input_event", self, "_on_input")

func _on_input(ev):
	if ev.type==InputEvent.MOUSE_BUTTON and ev.is_pressed() and ev.doubleclick:
		emit_signal("node_double_clicked", current_file)

func setup_action_popup(action_popup):
	self.action_popup = action_popup

func _on_choose_action_script():
	var selected_file = action_popup.get_current_file()
	var selected_path = action_popup.get_current_path()
	if selected_file != "":
		set_title(selected_file)
		current_file = selected_path
		current_file_name = selected_file
		var dir = Directory.new()
		dir.copy("res://addons/Behave/Editor/Scripts/templates/action_template.gd", selected_path)
		._init_model()
		emit_signal("lazy_model_initialized")
	else:
		queue_free()
		
func _init_model():
	pass # override to do nothing, model will be initilized after the file is choosed
	
	
func get_model_type():
	return load(current_file)

func get_behavior_name():
	return current_file_name.replace(".gd", "").capitalize()