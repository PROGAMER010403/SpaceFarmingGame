extends Node2D

@onready var LeftEndObject := $LeftEnd
@onready var RightEndObject := $RightEnd
@onready var WallAnimatorObject := $Wall/AnimationPlayer

var GreenOpenEndPrefab = preload("res://Prefabs/green_open_end.tscn")

@export var LEFT_END_OPEN_STATE : bool = true
@export var RIGHT_END_OPEN_STATE : bool = true

var knownLeftEndOpenState : bool
var knownRightEndOpenState : bool


func _process(delta):
	if LEFT_END_OPEN_STATE != knownLeftEndOpenState:
		update_left_greenopenend()
	
	if RIGHT_END_OPEN_STATE != knownRightEndOpenState:
		update_right_greenopenend()
	
	if GlobalStatesManager.isZoomStateJustChanged == true:
		update_wall_state()


func update_left_greenopenend():
	if LEFT_END_OPEN_STATE == true && is_greenopenend_child(LeftEndObject) == false:
		var GreenOpenEndInstance = GreenOpenEndPrefab.instantiate()
		GreenOpenEndInstance.name = "GreenOpenEnd"
		knownLeftEndOpenState = true
		LeftEndObject.add_child(GreenOpenEndInstance)
		if GlobalStatesManager.ZOOM_OUT_STATE == false:
			GreenOpenEndInstance.hide()
		
	elif LEFT_END_OPEN_STATE == false && is_greenopenend_child(LeftEndObject) == true:
		LeftEndObject.get_node("GreenOpenEnd").queue_free()
		knownLeftEndOpenState = false


func update_right_greenopenend():
	if RIGHT_END_OPEN_STATE == true && is_greenopenend_child(RightEndObject) == false:
		var GreenOpenEndInstance = GreenOpenEndPrefab.instantiate()
		RightEndObject.add_child(GreenOpenEndInstance)
		GreenOpenEndInstance.name = "GreenOpenEnd"
		knownRightEndOpenState = true
		if GlobalStatesManager.ZOOM_OUT_STATE == false:
			GreenOpenEndInstance.hide()
		
	elif RIGHT_END_OPEN_STATE == false && is_greenopenend_child(RightEndObject) == true:
		RightEndObject.get_node("GreenOpenEnd").queue_free()
		knownRightEndOpenState = false


func is_greenopenend_child(parent):
	var isChild : bool
	for i in parent.get_children():
		if i.name == "GreenOpenEnd":
			isChild = true
		else:
			isChild = false
	return isChild


func update_wall_state():
	if GlobalStatesManager.ZOOM_OUT_STATE == true:
		WallAnimatorObject.play("Fade_In")
		if is_greenopenend_child(LeftEndObject):
			LeftEndObject.get_node("GreenOpenEnd").show()
		if is_greenopenend_child(RightEndObject):
			RightEndObject.get_node("GreenOpenEnd").show()
		
	elif GlobalStatesManager.ZOOM_OUT_STATE == false:
		WallAnimatorObject.play("Fade_Out")
		if is_greenopenend_child(LeftEndObject):
			LeftEndObject.get_node("GreenOpenEnd").hide()
		if is_greenopenend_child(RightEndObject):
			RightEndObject.get_node("GreenOpenEnd").hide()
