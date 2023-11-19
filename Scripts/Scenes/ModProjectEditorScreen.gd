extends Control

@onready var searchFilesLineEdit = $PanelContainer/MarginContainer/VBoxContainer/Editor/DirectoryExplorer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/HBoxContainer/SearchFilesLineEdit
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
		treeItem.set_icon(0, load("res://Assets/" + ("Hidden" if i["isHidden"] else "") + ("Folder.svg" if i["isDir"] else "File.svg")))
		treeItem.set_icon_max_width(0, 16 if i["isDir"] else 14)
		treeItem.visible = !i["isHidden"]
		
		if i["isDir"]:
			treeItem.collapsed = true
			createDirectoryTreeButtons(path + "/" + i["name"], treeItem)

func onToggleHiddenFilesButtonToggled(button_pressed):
	toggleHiddenFilesButton.icon = load("res://Assets/" + ("Eye.svg" if button_pressed else "EyeSlash.svg"))
	toggleHiddenFilesButton.tooltip_text = ("Hide" if button_pressed else "Show") + " hidden files"
	
	for i in directoryTree.get_root().get_children():
		var fileInfo = Main.findItemInDirectoryArray(Main.getContentsOfDirectory(Main.modProjectDirectory, false)["contents"], "name", i.get_text(0))
		
		if fileInfo["isHidden"]:
			i.visible = button_pressed && (searchFilesLineEdit.text.is_empty() || fileInfo["name"].to_lower().contains(searchFilesLineEdit.text.to_lower()))

func onSearchFilesLineEditTextChanged(new_text):
	for i in directoryTree.get_root().get_children():
		var fileInfo = Main.findItemInDirectoryArray(Main.getContentsOfDirectory(Main.modProjectDirectory, false)["contents"], "name", i.get_text(0))
		
		if fileInfo["isHidden"] && !toggleHiddenFilesButton.button_pressed:
			continue
		
		i.visible = new_text.is_empty() || fileInfo["name"].to_lower().contains(new_text.to_lower())
