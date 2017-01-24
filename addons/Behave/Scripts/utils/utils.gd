extends Node

static func load_tree_nodes(path):
	var tree_nodes = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	var node_name = dir.get_next()
	while node_name != "":
		if dir.current_is_dir():
			node_name = dir.get_next()
			continue
		var node_instace = load(path + node_name)
		if node_instace:
			tree_nodes.append(node_instace)
		node_name = dir.get_next()
	dir.list_dir_end()
	return tree_nodes


static func create_new_behavior_node(node_name, node_type, params):
	var new_node = node_type.new(params)
	new_node.set_name(node_name)
	return new_node
