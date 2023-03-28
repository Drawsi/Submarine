extends CanvasLayer

@onready var coord = get_node("Screen/coord")
@onready var img = preload("res://00.png")
@onready var slider = get_node("Screen/VSlider")
var point = preload("res://Test_Scene/point.tscn")
var danger = preload("res://Test_Scene/danger.tscn")
var degg
var x1
var y1
var x2
var y2
var viz = false

func add_point():
	#if Sonar.x != x1 || Sonar.y != y1:
		#coord.newline()
		#coord.add_image(img,100,50)
		#coord.add_text(str(Sonar.x)+"     "+str(Sonar.y))
								#Adding the point
		var p = point.instantiate()
	#	x1 = Sonar.x
	#	y1 = Sonar.y
	#	p.position = Vector2(x1,y1) - Sonar.player_pos
		$Screen/Center_XY.add_child(p)
	#if Sonar.x2 != x2 || Sonar.y2 != y2:
		#coord.newline()
		#coord.add_text(str(Sonar.x2)+"     "+str(Sonar.y2))
								#Adding the point
		var p2 = point.instantiate()
	#	x2 = Sonar.x2
	#	y2 = Sonar.y2
	#	p2.position = Vector2(x2,y2) - Sonar.player_pos
		$Screen/Center_XY.add_child(p2)
	

func warning():
	for i in $Warning/Red.get_children():
		i.visible = false
	#if Sonar.warn:
	#	$Warning/Red.get_node(Sonar.warn).visible = true
		if $Warning/Beep.playing == false:
			$Warning/Beep.play()
	#	Sonar.warn = false
	#else:
	#	$Warning/Beep.stop()
	#slider.set_value(Sonar.gear)
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		self.visible=viz
		viz=!viz
	add_point()
	warning()
	#var rot = Sonar.player_deg
	#$Screen/icon.rotation_degrees = rot + 90
	#$Screen/ScanLine.rotation_degrees = Sonar.scan_deg + 180
	#$Warning/Red.rotation_degrees = rot + 90
