extends Control

var openModProjectPanelVisible = false: set = setOpenModProjectPanelVisible
var creatingAModGuideVisible = false: set = setCreatingAModGuideVisible
var modSources = getContentsOfDirectory(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + "/My Games/Terraria/tModLoader/ModSources")

@onready var titleScreenContent = $PanelContainer/TitleScreenContent
@onready var openModProjectPanelContent = $PanelContainer/OpenModProjectPanelContent
@onready var creatingAModGuideContent = $PanelContainer/CreatingAModGuideContent
@onready var emptyDirectoryText = $PanelContainer/OpenModProjectPanelContent/PanelContainer/MarginContainer/EmptyDirectoryText
@onready var modProjectsContainer = $PanelContainer/OpenModProjectPanelContent/PanelContainer/MarginContainer/VBoxContainer/ModProjectsContainer

func _ready():
	openModProjectPanelVisible = false
	creatingAModGuideVisible = false
	titleScreenContent.visible = true
	
	emptyDirectoryText.visible = modSources == null || modSources["folders"].is_empty()
	
	if emptyDirectoryText.visible:
		return
	
	for i in modSources["folders"]:
		print(i)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		exitSubmenu()

func exitSubmenu():
	if openModProjectPanelVisible:
		openModProjectPanelVisible = false
	elif creatingAModGuideVisible:
		creatingAModGuideVisible = false

func setOpenModProjectPanelVisible(state):
	openModProjectPanelVisible = state
	titleScreenContent.visible = !state
	openModProjectPanelContent.visible = state

func setCreatingAModGuideVisible(state):
	creatingAModGuideVisible = state
	titleScreenContent.visible = !state
	creatingAModGuideContent.visible = state
	
func onOpenModProjectButtonPressed():
	openModProjectPanelVisible = true

func onCreatingAModButtonPressed():
	creatingAModGuideVisible = true

func onExitButtonPressed():
	exitSubmenu()

func onRichTextLabelMetaClicked(meta):
	OS.shell_open(meta)

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
