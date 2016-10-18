
extends PopupDialog

var settings = [
	[9,9,10],
	[16,16,40],
	[16,32,99]
	]

onready var WidthBox = get_node('box/options/custom/width/SpinBox')
onready var HeightBox = get_node('box/options/custom/height/SpinBox')
onready var MinesBox = get_node('box/options/custom/mines/SpinBox')






func _on_difficulty_button_selected( idx ):
	WidthBox.set_value(settings[idx][0])
	HeightBox.set_value(settings[idx][1])
	MinesBox.set_value(settings[idx][2])


func _on_Cancel_pressed():
	hide()


func _on_OK_pressed():
	var W = WidthBox.get_value()
	var H = HeightBox.get_value()
	var M = MinesBox.get_value()
	get_parent().new_game(W,H,M)
	hide()
