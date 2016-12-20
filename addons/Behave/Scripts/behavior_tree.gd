extends Node

var child = null
var tickable_tasks
var open_tasks

var first_tick = true

var context = {
	target = get_parent(),
	tree = self
}

func _ready():
	set_process(true)
	pass

func _process(delta):
	if first_tick:
		child.on_enter()
	else:
		for t in tickable_tasks:
			t.tick(context)
	pass