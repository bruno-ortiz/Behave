tool

extends PopupPanel

signal action_selected(action)

var utils =  preload("res://addons/Behave/Scripts/utils/utils.gd")
var Constants = preload("res://addons/Behave/Scripts/utils/constants.gd").new()

var actions = null

onready var action_list = get_node("ActionList")
onready var new_action_button = get_node("HBoxContainer/ToolButton")
onready var new_action_text = get_node("HBoxContainer/ActionName")

func _ready():
	_ensure_dir_exists()
	actions = utils.load_actions(Constants.ACTION_PATH)
	for action in actions:
		action_list.add_item(action.substr(action.rfind("/") + 1, action.length()).replace(".gd",""))
	
	action_list.connect("item_selected", self, "_on_item_selected")
	new_action_button.connect("pressed", self, "_on_new_action_pressed")
	new_action_text.connect("text_changed", self, "_on_action_name_changed")
	
	new_action_button.set_disabled(true)
	

func _on_action_name_changed():
	var actual_name = new_action_text.get_text()
	if actual_name == "":
		 new_action_button.set_disabled(true)
	else:
		new_action_button.set_disabled(false)


func _on_item_selected(id):
	emit_signal("action_selected", actions[id])
	queue_free()


func _on_new_action_pressed():
	var dir = Directory.new()
	var new_action_path = Constants.ACTION_PATH + new_action_text.get_text() + ".gd"
	dir.copy("res://addons/Behave/Scripts/action/action_template.gd", new_action_path)
	emit_signal("action_selected", new_action_path)
	queue_free()


func _ensure_dir_exists():
	var dir = Directory.new()
	if not dir.dir_exists(Constants.ACTION_PATH):
		dir.make_dir(Constants.ACTION_PATH)