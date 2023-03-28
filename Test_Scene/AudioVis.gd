extends Node2D

const VU_COUNT = 16
const FREQ_MAX = 10000.0 # 21050.0

const WIDTH = 400
const HEIGHT = 100

const MIN_DB = 100

var spectrum

func _ready():
	spectrum = AudioServer.get_bus_effect_instance(1,0)

func _draw():
	var w = WIDTH/VU_COUNT
	var prev_hz = 0
	for i in range(1,VU_COUNT+1):
		var hz = (i+1)*FREQ_MAX/VU_COUNT
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz,hz).length()
		var energy = clamp(10 + linear_to_db(f)/10,0,1)
		var height = energy*HEIGHT
		draw_rect(Rect2(w*i,HEIGHT-height,w,height),Color(1,1,1))
		prev_hz = hz
		

func _process(_delta):
	update()
