extends Node2D

@onready var Sprite2DObject = $Sprite2D
@onready var Area2DObject = $HumanPodArea2D

@export var POD_STATE : int # 1 = Empty | 2 = Child | 3 = Adult | 4 = Destroyed

func _ready():
	contain_child()

func contain_empty():
	POD_STATE = 1
	Sprite2DObject.frame = 0
	Area2DObject.collision_layer = pow(2, 1-1)


func contain_child():
	POD_STATE = 2
	Sprite2DObject.frame = 1
	Area2DObject.collision_layer = pow(2, 1-1) + pow(2, 2-1)


func contain_adult():
	POD_STATE = 3
	Sprite2DObject.frame = 2
	Area2DObject.collision_layer = pow(2, 1-1) + pow(2, 2-1)


func destroyed():
	POD_STATE = 4
	Sprite2DObject.frame = 3
	Area2DObject.collision_layer = pow(2, 1-1)
