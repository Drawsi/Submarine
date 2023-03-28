extends Node2D

func _ready():
	$Control.visible = true
	$Control/VBoxContainer/CONNECT.grab_focus()


func _on_DISCONNECT_pressed():
	$BG.color = Color(1, 0, 0, 1)
	$AnimationPlayer.play("shut_down")


func _on_AnimationPlayer_animation_finished(done):
	if done == "shut_down":
		get_tree().quit()
	elif done == "connect":
		get_tree().change_scene_to_file("res://Levels/1.tscn")

func _on_CONNECT_pressed():
	$AnimationPlayer.play("connect")
