extends Control

var openModProjectPanelVisible = false: set = setOpenModProjectPanelVisible
var creatingAModGuideVisible = false: set = setCreatingAModGuideVisible

var modProjectButtonScene = preload("res://Scenes/Nodes/ModProjectButton.tscn")

@onready var titleScreenContent = $PanelContainer/TitleScreenContent
@onready var openModProjectPanelContent = $PanelContainer/OpenModProjectPanelContent
@onready var creatingAModGuideContent = $PanelContainer/CreatingAModGuideContent
@onready var emptyDirectoryText = $PanelContainer/OpenModProjectPanelContent/PanelContainer/MarginContainer/EmptyDirectoryText
@onready var modProjectsContainer = $PanelContainer/OpenModProjectPanelContent/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/ModProjectsContainer

func _ready():
	openModProjectPanelVisible = false
	creatingAModGuideVisible = false
	titleScreenContent.visible = true
	
	emptyDirectoryText.visible = Main.modSources == null || Main.modSources["folders"].is_empty()
	
	if emptyDirectoryText.visible:
		return
	
	for i in Main.modSources["folders"]:
		var modProjectButton = modProjectButtonScene.instantiate()
		modProjectButton.set("path", Main.modSources["path"] + "/" + i)
		modProjectsContainer.add_child(modProjectButton)

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
