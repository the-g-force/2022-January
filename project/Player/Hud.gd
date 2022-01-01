extends CanvasLayer

const ARMOR_MESSAGE := "Armor: "
const CARGO_MESSAGE := "Cargo: "
const POINT_MESSAGE := "Points: "

onready var _cargo_label := $HUD/VBoxContainer/CargoLabel
onready var _armor_label := $HUD/VBoxContainer/ArmorLabel
onready var _point_label := $HUD/VBoxContainer/PointLabel
onready var _seconds_display := $HUD/Label
onready var _game_over_message := $HUD/GameOverMessage
onready var _game_over_buttons := $HUD/GameOverButtons

var _points := 0
var _seconds_left := 60
var _game_over := false


func _ready()->void:
	_game_over_buttons.visible = false
	_game_over_message.visible = false


func _on_Player_update_armor(armor:int)->void:
	_armor_label.text = ARMOR_MESSAGE + str(armor)


func _on_Player_update_salvage(salvage:int)->void:
	_cargo_label.text = CARGO_MESSAGE + str(salvage)


func _on_PlayAgain_pressed()->void:
	var _ignored = get_tree().change_scene("res://World/World.tscn")


func _on_MainMenu_pressed()->void:
	var _ignored = get_tree().change_scene("res://Intro/MainMenu.tscn")


func _on_Player_update_points(additional_points:int)->void:
	_points += additional_points
	_point_label.text = POINT_MESSAGE + str(_points)


func _on_SecondTimer_timeout()->void:
	if _seconds_left > 0:
		_seconds_left -= 1
	_seconds_display.text = str(_seconds_left)


func _on_Player_set_game_time(game_length:int)->void:
	_seconds_left = game_length
	_seconds_display.text = str(_seconds_left)


func _on_Player_game_over()->void:
	_game_over_buttons.visible = true
	_game_over_message.visible = true
	_game_over_message.text = "Game over! You got "+str(_points)+" points!"
	if _seconds_left == 1:
		_seconds_display.text = "0"
