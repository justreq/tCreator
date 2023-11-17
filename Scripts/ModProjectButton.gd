extends Button

@export var modIcon: Texture2D
@export var modDisplayName: String
@export var versionNumber: String
@export var authorName: String

@onready var modIconTextureRect = $MarginContainer/HBoxContainer/TextureRect
@onready var modDisplayNameAndVersionNumberLabel = $MarginContainer/HBoxContainer/VBoxContainer/Label
@onready var modAuthorNameLabel = $MarginContainer/HBoxContainer/VBoxContainer/Label2

func _ready():
	assert(modIcon, "Mod Icon required")
	assert(modDisplayName, "Mod Display Name required")
	assert(versionNumber, "Version Number required")
	assert(authorName, "Author Name required")
	
	modIconTextureRect.texture = modIcon
	modDisplayNameAndVersionNumberLabel.text = modDisplayName + " v" + versionNumber
	modAuthorNameLabel.text = authorName
