extends Control

var InternalName: String = ""
var DisplayName: String = ""
var AuthorName: String = ""

@onready var CreateModProjectDialog: ConfirmationDialog = $CreateModProjectDialog
@onready var InternalNameLineEdit: LineEdit = $CreateModProjectDialog/VBoxContainer/InternalNameLineEdit
@onready var DisplayNameLineEdit: LineEdit = $CreateModProjectDialog/VBoxContainer/DisplayNameLineEdit
@onready var AuthorNameLineEdit: LineEdit = $CreateModProjectDialog/VBoxContainer/AuthorNameLineEdit

func resetCreateModProjectDialog():
	InternalNameLineEdit.text = ""
	InternalName = ""
	DisplayNameLineEdit.text = ""
	DisplayName = ""
	AuthorNameLineEdit.text = ""
	AuthorName = ""

func onCreateModProjectButtonPressed():
	CreateModProjectDialog.visible = true

func onInternalNameLineEditTextChanged(new_text):
	InternalName = new_text

func onDisplayNameLineEditTextChanged(new_text):
	DisplayName = new_text

func onAuthorNameLineEditTextChanged(new_text):
	AuthorName = new_text

func onCreateModProjectDialogConfirmed():
	resetCreateModProjectDialog()

func onCreateModProjectDialogCanceled():
	resetCreateModProjectDialog()
