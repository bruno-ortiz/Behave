tool

extends EditorPlugin

var ActionPopup = preload("res://addons/Behave/Scenes/ActionPopup.tscn")
var ActionInitializer = preload("res://addons/Behave/Scripts/action/action_initializer.gd")
var action_stub = null

func _enter_tree():
	add_custom_type("BehaviorTree", "Node", preload("res://addons/Behave/Scripts/behavior_tree.gd"),  preload("res://addons/Behave/Icons/behv_root_icon.png"))
	
	add_custom_type("Sequence", "Node", preload("res://addons/Behave/Scripts/composite/sequence.gd"),  preload("res://addons/Behave/Icons/behv_seq_icon.png"))
	add_custom_type("Parallel", "Node", preload("res://addons/Behave/Scripts/composite/parallel.gd"), null)
	add_custom_type("Selector", "Node", preload("res://addons/Behave/Scripts/composite/selector.gd"),  preload("res://addons/Behave/Icons/behv_sel_icon.png"))
	
	add_custom_type("UntilFailure", "Node", preload("res://addons/Behave/Scripts/decorator/until_failure.gd"), null)
	add_custom_type("UntilSuccess", "Node", preload("res://addons/Behave/Scripts/decorator/until_success.gd"), null)
	add_custom_type("Repeater", "Node", preload("res://addons/Behave/Scripts/decorator/repeater.gd"), null)
	add_custom_type("Inverter", "Node", preload("res://addons/Behave/Scripts/decorator/inverter.gd"), null)
	add_custom_type("ReturnSuccess", "Node", preload("res://addons/Behave/Scripts/decorator/success.gd"), null)
	add_custom_type("ReturnFailure", "Node", preload("res://addons/Behave/Scripts/decorator/failure.gd"), null)
	add_custom_type("Interrupt", "Node", preload("res://addons/Behave/Scripts/decorator/interrupt.gd"), null)
	
	add_custom_type("PerformInterruption", "Node", preload("res://addons/Behave/Scripts/action/perform_interruption.gd"), null)
	add_custom_type("ActionTask", "Node", preload("res://addons/Behave/Scripts/action/action_initializer.gd"),  preload("res://addons/Behave/Icons/behv_action_icon.png"))
	

func _exit_tree():
	remove_custom_type("BehaviorTree")
	
	remove_custom_type("Sequence")
	remove_custom_type("Selector")
	remove_custom_type("Parallel")
	
	remove_custom_type("UntilFailure")
	remove_custom_type("UntilSuccess")
	remove_custom_type("Repeater")
	remove_custom_type("Inverter")
	remove_custom_type("ReturnSuccess")
	remove_custom_type("ReturnFailure")
	remove_custom_type("Interrupt")
	
	remove_custom_type("PerformInterruption")
	remove_custom_type("ActionTask")
	


func handles(object):
	var action_popup
	if object extends ActionInitializer:
		action_stub = object
		action_popup = ActionPopup.instance()
		action_popup.connect("action_selected", self, "_on_action_selected")
		get_base_control().add_child(action_popup)
		action_popup.popup_centered()
	else:
		action_stub = null
		if action_popup:
			action_popup.queue_free()
			

func _on_action_selected(action):
	print("new node ", action)
	var action_node = load(action).new()
	action_node.set_name(_get_action_name(action))
	action_stub.get_parent().add_child(action_node)
	action_node.set_owner(get_tree().get_edited_scene_root())
	action_stub.queue_free()
	
func _get_action_name(action):
	var expr = RegEx.new()
	expr.compile("res:\/\/.*\/(\\w+).gd")
	expr.find(action)
	return expr.get_capture(1).capitalize()