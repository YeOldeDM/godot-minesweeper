
extends Button

const NeighborColors = [
	Color(0.3,0.3,1),
	Color(0.3,1,0.3),
	Color(1,0.3,0.3),
	Color(0.3,1,1),
	Color(1,0.3,1),
	Color(1,1,0.3),
	Color(1,1,1)]

signal bomb
signal opened

var flagged = false setget _set_flagged

var mine = false setget _set_mine
var neighbors = 0 setget _set_neighbors

var clicklock = false

func draw_label():
	if mine:
		set_text("")
		set_button_icon(preload('res://mine.png'))
		#set('custom_colors/font_color_pressed',Color(1,0,0))
		
	elif neighbors > 0:
		set_text(str(neighbors))
		set('custom_colors/font_color_pressed',NeighborColors[neighbors-1])
	else:
		set_text(str(""))
	if flagged:
		set_text("F")

func _set_flagged(value):
	flagged = value
	if flagged:
		set_text("F")
	else:
		if is_pressed():
			draw_label()
		else:
			set_text("")

func _set_mine(value):
	mine = value


func _set_neighbors(value):
	neighbors = value
	if flagged:
		set('flagged',false)



func _ready():
	set_process_input(true)




func activate():
	set_pressed(true)
	set_ignore_mouse(true)
	set('flagged',false)
	if mine:
		emit_signal('bomb')
	else:
		emit_signal('opened')
	draw_label()

func _on_Button_pressed():
	if !get_node('/root/Game').game_over:
		activate()


func _input(event):
	if is_hovered():
		if event.type == InputEvent.MOUSE_BUTTON:
			if event.button_index == 2 and event.pressed:
				if !flagged:
					set('flagged',true)
				else:
					set('flagged',false)