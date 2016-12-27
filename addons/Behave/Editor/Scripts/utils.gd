extends Node


func _ready():
	pass

func load_tree_nodes(path):
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


func parse_json_from_file(path):
	var dict = {}
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	dict.parse_json(text)
	file.close()
	return dict 
	
func save_to_file(path, content):
    var file = File.new()
    file.open(path, file.WRITE)
    file.store_string(content)
    file.close()

func file_exists(path):
	var dir = Directory.new()
	return dir.file_exists(path)