extends Node2D

@onready var ship = $Ship
var rngx = RandomNumberGenerator.new()
var rngy = RandomNumberGenerator.new()

func _ready():
	rngx.randomize()
	rngy.randomize()
	var x = rngx.randi_range(0, 1920)
	var y = rngy.randi_range(0,1080)
	
	ship.position = Vector2(x,y)
