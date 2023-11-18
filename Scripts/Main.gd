extends Node2D

var modSources = getContentsOfDirectory(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + "/My Games/Terraria/tModLoader/ModSources")
var modProjectDirectory: String

func getBuildPropertyValue(path, key):
	return (readFile(path).split("\n") as Array).filter(func(x): return x.begins_with(key))[0].split("=")[1].strip_edges()

func getContentsOfDirectory(path, categorize = true):
	var dir = DirAccess.open(path)
	if !dir:
		return null
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	var directoryContents = {"path": path, "files": [], "folders": []} if categorize else {"path": path, "contents": []}
	
	while file_name != "":
		if categorize:
			directoryContents["folders" if dir.current_is_dir() else "files"].append(file_name)
		else:
			directoryContents["contents"].append({"name": file_name, "isDir": dir.current_is_dir()})
		
		file_name = dir.get_next()
	
	return directoryContents

func readFile(path):
	var file = FileAccess.open(path, FileAccess.READ)
	assert(FileAccess.file_exists(path), "File not found")
	return file.get_as_text()
