extends Node

static func load_actions(path):
	print("path: ", path)
	var actions = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	var action_name = dir.get_next()
	while action_name != "":
		if dir.current_is_dir():
			action_name = dir.get_next()
			continue
		actions.append(path + action_name)
		action_name = dir.get_next()
	dir.list_dir_end()
	return actions