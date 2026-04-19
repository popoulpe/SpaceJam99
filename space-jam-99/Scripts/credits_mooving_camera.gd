extends Camera3D

var f:float = 0.0
@export var fVitesse : float = 1.0

func _process(delta: float) -> void:
	f+=delta*fVitesse
	$".".rotation.y = f
