extends Control

@export var bottleList:Array[Bottle]

var selected:int=-1

func bottle_selection(id:int):
	if selected < 0 && bottleList[id].actualQtt>0:
		selected = id
	elif selected >= 0 && !bottleList[id].actualQtt >= bottleList[id].MAX_LIQUID:
		var col:Color = bottleList[selected].empty()
		bottleList[id].fill(col)
		selected = -1
		check_end()
	else:
		selected = -1

func check_end():
	var finished :bool=true
	for i in range(bottleList.size()):
		if !bottleList[i].isFinished():
			finished = false
	
	if finished:
		print("YOUPIIIII")
