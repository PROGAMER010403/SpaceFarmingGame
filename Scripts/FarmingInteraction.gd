extends Node2D

func interacted():
	get_parent().get_parent().get_node("Control").show()
