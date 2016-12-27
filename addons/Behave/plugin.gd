tool

extends EditorPlugin

var utils = preload("res://addons/Behave/Editor/Scripts/utils.gd").new()
var BehaviorTree = preload("res://addons/Behave/Scripts/behavior_tree.gd")
var editor = preload("res://addons/Behave/Editor/Scenes/BehaviorTreeEditor.tscn")
var editor_instance
var script_editor
var current_tree = null
var bottom_button = null


func _enter_tree():
	add_custom_type("BehaviorTree", "Node", preload("res://addons/Behave/Scripts/behavior_tree.gd"),  preload("res://addons/Behave/behv_root_icon.png"))
	editor_instance = editor.instance()
	editor_instance.connect("node_double_clicked", self, "_on_action_double_clicked")

func _exit_tree():
	remove_control_from_bottom_panel(editor_instance)
	remove_custom_type("BehaviorTree")
	queue_free()

func handles(object):
	if object extends BehaviorTree:
		current_tree = object
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

func save_external_data():
	if current_tree:
		if current_tree.tree_file == null or current_tree.tree_file == "":
			var dialog = _create_save_tree_dialog()
			get_base_control().add_child(dialog)
			dialog.popup_centered()
	pass

func _create_save_tree_dialog():
		var dialog = FileDialog.new()
		dialog.set_exclusive(true)
		dialog.set_size(Vector2(500, 500))
		dialog.add_filter("*.json")
		dialog.set_title("Open or Create Tree")
		dialog.connect("file_selected", self, "_on_tree_file_selected")
		return dialog
	

func _on_tree_file_selected(path):
	print("tree path: ", path)
	current_tree.tree_file = path
	if utils.file_exists(path):
		print("File exists!!!")
		utils.save_to_file(path, current_tree.get_model().to_json())
	else:
		utils.save_to_file(path, {}.to_json())