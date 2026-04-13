extends Control

@export var fioles:Array[fioleFeelings]

var selected:int=-1

func _on_texture_rect_button_down(extra_arg_0):
	if selected < 0 && fioles[extra_arg_0].actualQtt>0:
		selected = extra_arg_0
	elif selected >= 0 && !fioles[extra_arg_0].isFilled:
		var col:Color = fioles[selected].empty(fioles[extra_arg_0].position)
		fioles[extra_arg_0].fill(col)
		selected = -1
		checkEnd()
	else:
		selected = -1

func checkEnd():
	var finished :bool=true
	for i in range(fioles.size()):
		if !fioles[i].isFinished():
			finished = false
	
	if finished:
		print("YOUPIIIII")
