extends Area3D
class_name Interactable

var isMiniGame:bool=false

func _on_body_entered(body):
	body.player.start_detection_interact(self, isMiniGame)
	
func _on_body_exited(body):
	body.player.end_detection_interact(isMiniGame)


func Interact(_player:PlayerWithoutSkate) -> void:
	print("Interaction completed")
