extends CanvasLayer

const ARMOR_MESSAGE := "Armor: "
const CARGO_MESSAGE := "Cargo: "

onready var _cargo_label := $HUD/CargoLabel
onready var _armor_label := $HUD/ArmorLabel
onready var _game_over_message := $HUD/GameOverMessage
onready var _game_over_buttons := $HUD/GameOverButtons


func _ready()->void:
	_game_over_buttons.visible = false
	_game_over_message.visible = false


func _on_Player_update_armor(armor:int)->void:
	_armor_label.text = ARMOR_MESSAGE + str(armor)


func _on_Player_update_salvage(salvage:int)->void:
	_cargo_label.text = CARGO_MESSAGE + str(salvage)


func _on_Player_dead()->void:
	_game_over_buttons.visible = true
	_game_over_message.visible = true


func _on_PlayAgain_pressed()->void:
	var _ignored = get_tree().change_scene("res://World/World.tscn")


func _on_MainMenu_pressed()->void:
	var _ignored = get_tree().change_scene("res://Intro/MainMenu.tscn")
