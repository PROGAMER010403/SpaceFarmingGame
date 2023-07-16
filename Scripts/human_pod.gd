extends Node2D

@onready var Sprite2DObject = $Sprite2D
@onready var Area2DObject = $HumanPodArea2D
@onready var NotifUIObject = $NotifUI

@export var POD_STATE : int # 1 = Empty | 2 = Child | 3 = Adult | 4 = Destroyed

var isFedLastCycle : bool

var currentNotifID
var defaultNotifText = "\nRequired"

var lastCycle : int = 1
var currentCycle : int = 1

var lastPhase : int = 1
var currentPhase : int = 1

var isReqsMet = false

func _ready():
	updateNotifier()
	if POD_STATE == 1:
		contain_empty()
	elif POD_STATE == 2:
		contain_child()
	elif POD_STATE == 3:
		contain_adult()
	elif POD_STATE == 4:
		destroyed()


func _process(delta):
	currentCycle = GlobalStatesManager.currentCycleCount
	if currentCycle != lastCycle:
		updateNotifier()


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


func interacted():
	resolveNotification()


func updateNotifier():
	if POD_STATE == 1:
		NotifUIObject.get_node("NotifLabel").text = "Empty\nContainer"
		NotifUIObject.visible = true
		currentNotifID = 1
	elif POD_STATE == 2:
		POD_STATE = 3
		contain_adult()
		NotifUIObject.get_node("NotifLabel").text = "Food" + defaultNotifText
		NotifUIObject.visible = true
		currentNotifID = 2
	elif POD_STATE == 3 && isFedLastCycle == false:
		NotifUIObject.get_node("NotifLabel").text = "Food" + defaultNotifText
		NotifUIObject.visible = true
		currentNotifID == 2
	elif POD_STATE == 3 && isFedLastCycle == true:
		NotifUIObject.get_node("NotifLabel").text = "Harvest" + defaultNotifText
		NotifUIObject.visible = true
		currentNotifID = 3
		isFedLastCycle == false
	elif POD_STATE == 4:
		NotifUIObject.get_node("NotifLabel").text = "Repair" + defaultNotifText
		NotifUIObject.visible = true
		currentNotifID = 4
	lastCycle = currentCycle


func resolveNotification():
	if currentNotifID == 1:
		if GlobalStatesManager.currentFoodResource < 1:
			isReqsMet = false
		elif GlobalStatesManager.currentFoodResource >= 1:
			isReqsMet = true
			NotifUIObject.visible = false
			POD_STATE = 2
			contain_child()
			isFedLastCycle = false
			GlobalStatesManager.currentFoodResource -= 1
			GlobalStatesManager.GoalHUDObject.update_resources()
	elif currentNotifID == 2:
		if GlobalStatesManager.currentFoodResource < 2:
			isReqsMet = false
		elif GlobalStatesManager.currentFoodResource >= 2:
			isReqsMet = true
			NotifUIObject.visible = false
			isFedLastCycle = true
	elif currentNotifID == 3:
		NotifUIObject.visible = false
		POD_STATE = 1
		GlobalStatesManager.currentHumansCount += 1
		GlobalStatesManager.GoalHUDObject.update_human_goals()
		contain_empty()
	elif currentNotifID == 4:
		if GlobalStatesManager.currentMaterialsResource < 2:
			isReqsMet = false
		elif GlobalStatesManager.currentMaterialsResource >= 2:
			isReqsMet = true
			NotifUIObject.visible = false
			POD_STATE = 1
			contain_empty()
			GlobalStatesManager.currentMaterialsResource -= 2 
