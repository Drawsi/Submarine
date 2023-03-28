extends CharacterBody2D

@export var speed = 35
@export var rotation_speed = 1.5
@onready var gear = clamp(0,-2,2)

var point = preload("res://Test_Scene/point.tscn")

var ray_rotation_speed = 4
var ray_size = 200
var rotation_dir = 0
var closest=100
var c

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_just_pressed("down"):
		gear=clamp(gear-1,-2,2)
	if Input.is_action_just_pressed("up"):
		gear=clamp(gear+1,-2,2)
	velocity = Vector2(speed*gear, 0).rotated(rotation)
	$Screen/Gear_Slider.value = gear

func rays():
	#			We update the values of the rays
	$Rays.rotation_degrees += ray_rotation_speed
	$Screen/ScanLine.rotation_degrees += ray_rotation_speed
	$Screen/Sub_Icon.rotation_degrees = self.rotation_degrees + 90
	$Rays/ray.target_position.y = ray_size
	$Rays/ray2.target_position.y = ray_size
	#			We check on ray_size chosen
	if Input.is_key_pressed(KEY_1) or Input.is_key_pressed(KEY_KP_1):
		ray_size = lerpf(ray_size,50,1)
		ray_rotation_speed = lerpf(ray_rotation_speed,10,1)
		$Screen/ScanLine.set_point_position(0,Vector2(0,90))
		$Screen/ScanLine.set_point_position(2,Vector2(0,-90))
	elif Input.is_key_pressed(KEY_2) or Input.is_key_pressed(KEY_KP_2):
		ray_size = lerpf(ray_size,200,1)
		ray_rotation_speed = lerpf(ray_rotation_speed,5,1)
		$Screen/ScanLine.set_point_position(0,Vector2(0,130))
		$Screen/ScanLine.set_point_position(2,Vector2(0,-130))
	elif Input.is_key_pressed(KEY_3) or Input.is_key_pressed(KEY_KP_3):
		ray_size = lerpf(ray_size,400,1)
		ray_rotation_speed = lerpf(ray_rotation_speed,2,1)
		$Screen/ScanLine.set_point_position(0,Vector2(0,200))
		$Screen/ScanLine.set_point_position(2,Vector2(2,-200))

var biggest = 0

func add_point():
	#current max_amount of points found: 120
	#if $Screen/Marker2D.get_child_count()>biggest:
	#	biggest = $Screen/Marker2D.get_child_count()
	#	print(biggest)
	if $Rays/ray.is_colliding() or $Rays/ray2.is_colliding():
								#Adding the point
		var p = point.instantiate()
		p.position = $Rays/ray.get_collision_point() - self.position
		$Screen/Marker2D.add_child(p)
		var p2 = point.instantiate()
		p2.position = $Rays/ray2.get_collision_point() - self.position
		$Screen/Marker2D.add_child(p2)

func close_col():
	for i in $Short_Scan.get_children():
		i.force_raycast_update()
#		c=null
		closest=100
		if i.is_colliding():
			var origin = i.global_transform.origin
			var collision_point = i.get_collision_point()
			var distance = origin.distance_to(collision_point)
			
			if distance<closest:
				closest=distance
				c=i

func _physics_process(delta):
	$Screen/TextureProgressBar.value = 50+rotation*15
	add_point()
	get_input()
	rays()
	close_col()
	rotation += rotation_dir * rotation_speed * delta
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity

func _on_area_2d_body_entered(body):
	if body.is_in_group("Ship"):
		$Progress.visible = true
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		$Progress/Timer.start()

func _on_timer_timeout():
	get_tree().quit()
