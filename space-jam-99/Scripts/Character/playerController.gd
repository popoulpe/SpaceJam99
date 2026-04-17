extends CharacterBody3D
class_name PlayerController

@onready var player :Player= $".."
@onready var playerVisual :player_visual= $Mesh

@onready var pushTimer := $PushTimer
@onready var invinsibility_timer = $InvinsibilityTimer

@onready var state_machine = $StateMachine

var pushing:bool = false

var canPush :bool = true
var horizontalDir :int=0

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event):
	horizontalDir = int(Input.get_action_strength("Left") - Input.get_action_strength("Right"))
	state_machine.process_input(event)

func _physics_process(delta: float) ->void:
	state_machine.process_physics(delta)
	#print("velocity: ", velocity.length(), " real velocity:", get_real_velocity().length())
	
	checkCollisions()
	move_and_slide()

func _process(delta):
	state_machine.process_frame(delta)

func _on_push_timer_timeout():
	canPush = true
	
func checkCollisions():
	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i)
		if col.get_collider().get_collision_layer() == 2:
			set_collision_mask_value(2, false)
			invinsibility_timer.start(player.invulnerabilityDuration)
			player.get_hit()




func _on_invinsibility_timer_timeout():
	set_collision_mask_value(2, true)
