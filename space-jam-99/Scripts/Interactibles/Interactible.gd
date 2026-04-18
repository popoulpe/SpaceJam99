extends Area3D
class_name Interactable



func _on_body_entered(body):
	body.player.start_detection_interact(self)
	
func _on_body_exited(body):
	body.player.end_detection_interact()


func Interact(_player:PlayerWithoutSkate) -> void:
	print("Interaction completed")
