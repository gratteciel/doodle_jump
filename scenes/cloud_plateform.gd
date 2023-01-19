extends StaticBody2D

export var jump_power = 0

signal delete_cloud(plateform)

func response() :
	emit_signal("delete_cloud",self)
