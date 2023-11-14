extends Control

@onready var TitleScreenContent = $PanelContainer/TitleScreenContent

func onCreatingAModButtonPressed():
	TitleScreenContent.visible = false
