extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var agent = $NavigationAgent3D
# Minimum speed of the mob in meters per second.
@export var min_speed = 0.2
# Maximum speed of the mob in meters per second.
@export var max_speed = 1.5

@export var max_hp = 3.0
@export var hp = max_hp
var player
var speed

func _ready():
	self.velocity = Vector3.ZERO
	speed = randf_range(min_speed, max_speed)


func _physics_process(_delta):
	if !player:
		return
	agent.target_position = player.global_transform.origin
	if agent.is_target_reached():
		self.velocity = Vector3.ZERO
		return
	if agent.is_target_reachable():
		var target = agent.get_next_path_position()
		var new_velocity = global_transform.origin.direction_to(target).normalized() * self.max_speed
		agent.set_velocity(new_velocity)
		self.velocity = new_velocity
		move_and_slide()



# We will call this function from the Main scene.
func initialize(start_position, player_):
	self.player = player_
	self.transform.origin = start_position
	agent = $NavigationAgent3D
	agent.target_position = player.transform.origin


func die():
	self.queue_free()
	
