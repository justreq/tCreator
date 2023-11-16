extends Control

var creatingAModGuideVisible = false: set = setCreatingAModGuideVisible

@onready var titleScreenContent = $PanelContainer/TitleScreenContent
@onready var creatingAModGuideContent = $PanelContainer/CreatingAModGuideContent

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") && creatingAModGuideVisible:
		creatingAModGuideVisible = false

func setCreatingAModGuideVisible(state):
	creatingAModGuideVisible = state
	titleScreenContent.visible = !state
	creatingAModGuideContent.visible = state

func onCreatingAModButtonPressed():
	creatingAModGuideVisible = true

func onExitButtonPressed():
	creatingAModGuideVisible = false


func onRichTextLabelMetaClicked(meta):
	OS.shell_open(meta)
