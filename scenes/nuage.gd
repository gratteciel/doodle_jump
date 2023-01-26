extends StaticBody2D

export var coefficient_rebond = 0

signal disparition(plateforme)

func interaction():
	emit_signal("disparition",self) #signal de disparition pour que le programme principal le détecte
