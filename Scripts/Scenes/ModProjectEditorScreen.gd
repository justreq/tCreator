extends Control

@onready var toggleHiddenFilesButton = $PanelContainer/MarginContainer/VBoxContainer/Editor/DirectoryExplorer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/HBoxContainer/ToggleHiddenFilesButton
@onready var directoryTree = $PanelContainer/MarginContainer/VBoxContainer/Editor/DirectoryExplorer/VBoxContainer/MarginContainer2/PanelContainer/Tree

func _ready():
	var root = directoryTree.create_item()
	root.set_text(0, Main.modProjectDirectory.split("/")[-1])
	createDirectoryTreeButtons(Main.modProjectDirectory, root)

func createDirectoryTreeButtons(path, tree):
	var directoryInfo = Main.getContentsOfDirectory(path, false)
	
	for i in directoryInfo["contents"]:
		var treeItem = tree.create_child()
		treeItem.set_text(0, i["name"])
		treeItem.set_icon(0, load("res://Assets/" + ("Folder.svg" if i["isDir"] else "File.svg")))
		treeItem.set_icon_max_width(0, 16 if i["isDir"] else 14)
		
		if i["isDir"]:
			# treeItem.collapsed = true
			createDirectoryTreeButtons(path + "/" + i["name"], treeItem)

func onToggleHiddenFilesButtonToggled(button_pressed):
	toggleHiddenFilesButton.icon = load("res://Assets/" + ("Eye.svg" if button_pressed else "EyeSlash.svg"))
