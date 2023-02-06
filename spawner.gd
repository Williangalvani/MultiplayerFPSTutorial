extends Node


@export var mob_scene: PackedScene


func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	
	var players: Array = $"..".players
	if players.size() == 0:
		print("no player")
		return
	var player = players[randi() % players.size()]
	var mob = mob_scene.instantiate()
	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = $"../SpawnPath/SpawnLocation"
	# And give it a random offset.
	mob_spawn_location.h_offset = randf()

	var player_position = player.transform.origin
	mob.initialize(mob_spawn_location.transform.origin, player_position)
	$"..".add_child(mob)
