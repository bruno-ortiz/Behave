
extends Node

signal select_node(node)

var Status = preload("res://addons/Behave/Scripts/utils/status.gd")

var child = null
var tickable_tasks = []
var open_tasks = []

var insertion_requests = []
var removal_requests = []

var first_tick = true

var context = {
	tree = self
}

func start_behave(kwargs = null):
	if kwargs:
		for k in kwargs:
			context[k] = kwargs[k]
	child = get_child(0)
	set_process(true)

func _process(delta):
	context["delta"] = delta
	context["target"] = get_parent()
	if first_tick:
		child.on_enter(context)
		first_tick = false
	else:
		for t in tickable_tasks:
			if not t.terminated:
				var new_status = t.tick(context)
				if new_status != Status.RUNNING:
					t.status = new_status
					removal_requests.append(t)
	_process_insertions_and_removals()
		

func _process_insertions_and_removals():
	for t in insertion_requests:
		self.tickable_tasks.append(t)
	for t in removal_requests:
		self.tickable_tasks.erase(t)
	
	self.insertion_requests.clear()
	self.removal_requests.clear()