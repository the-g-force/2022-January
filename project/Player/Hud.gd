extends CanvasLayer

const ARMOR_MESSAGE := "ARMOR: "
const CARGO_MESSAGE := "CARGO: "

onready var _cargo_label := $HUD/CargoLabel
onready var _armor_label := $HUD/ArmorLabel


func _on_Player_update_armor(armor:int)->void:
	_armor_label.text = ARMOR_MESSAGE + str(armor)


func _on_Player_update_salvage(salvage:int)->void:
	_cargo_label.text = CARGO_MESSAGE + str(salvage)
