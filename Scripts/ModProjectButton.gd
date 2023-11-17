extends Button

@export var path: String

@onready var modIconTextureRect = $MarginContainer/HBoxContainer/TextureRect
@onready var modDisplayNameLabel = $MarginContainer/HBoxContainer/VBoxContainer/Label
@onready var modAuthorNameLabel = $MarginContainer/HBoxContainer/VBoxContainer/Label2

func _ready():
	assert(path, "Mod Project Path required")
	
	var modIcon = Image.new()
	modIcon.load(path + "/icon.png")
	
	modIconTextureRect.texture = ImageTexture.create_from_image(modIcon)
	modDisplayNameLabel.text = Globals.getBuildPropertyValue(path + "/build.txt", "displayName")
	modAuthorNameLabel.text = Globals.getBuildPropertyValue(path + "/build.txt", "author")
