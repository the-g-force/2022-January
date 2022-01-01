extends AudioStreamPlayer

var _music_bus_index = AudioServer.get_bus_index('Music')

func _unhandled_input(event):
	if event.is_action_pressed('mute'):
		var is_muted = AudioServer.is_bus_mute(_music_bus_index)
		AudioServer.set_bus_mute(_music_bus_index, not is_muted)
