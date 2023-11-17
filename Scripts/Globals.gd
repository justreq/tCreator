extends Node2D

func getBuildPropertyValue(path, key):
	return (Globals.readFile(path).split("\n") as Array).filter(func(x): return x.begins_with(key))[0].split("=")[1].strip_edges()

func getContentsOfDirectory(path):
	var dir = DirAccess.open(path)
	if !dir:
		return null
	
	dir.list_dir_begin()
	var directoryContents = {"path": path, "files": [], "folders": []}
	var file_name = dir.get_next()
	
	while file_name != "":
		directoryContents["folders" if dir.current_is_dir() else "files"].append(file_name)
		file_name = dir.get_next()
	
	return directoryContents

func readFile(path):
	var file = FileAccess.open(path, FileAccess.READ)
	assert(file.file_exists(path), "File not found")
	return file.get_as_text()
