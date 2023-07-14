extends Node2D

@onready var ContainerObject := $Container
@onready var LeftEndObject := $Container/LeftEnd
@onready var RightEndObject := $Container/RightEnd
@onready var WallAnimatorObject := $Container/Wall/AnimationPlayer

@export var MODULE_STATE : int # 1 = Hover | 2 = Snapped | 3 = Placed

var GreenOpenEndIcon = preload("res://Assets/Sprites/icon.svg")

var snapTo : Object

func _ready():
	update_state_characteristics()
	update_walls()


func _process(delta):
	if GlobalStatesManager.isZoomStateJustChanged:
		update_walls()
	
	if MODULE_STATE == 1:
		if get_global_mouse_position().x >= 0:
			GlobalStatesManager.CurrentModuleAtMouse.ContainerObject.position.x = 590
			global_position = get_global_mouse_position()
		elif get_global_mouse_position().x <= 0:
			GlobalStatesManager.CurrentModuleAtMouse.get_node("Container/Room").scale.x = -10
			GlobalStatesManager.CurrentModuleAtMouse.get_node("Container/Wall").scale.x = -10
			GlobalStatesManager.CurrentModuleAtMouse.ContainerObject.position.x = -590
			global_position = get_global_mouse_position()
	elif MODULE_STATE == 2:
		GlobalStatesManager.CurrentModuleAtMouse.global_position = snapTo.global_position


func _input(event):
	if event.is_action_pressed("Mouse_Left_Click") && GlobalStatesManager.CurrentModuleAtMouse != null && snapTo != null:
		GlobalStatesManager.CurrentModuleAtMouse.MODULE_STATE = 3
		GlobalStatesManager.CurrentModuleAtMouse.z_index = snapTo.get_parent().get_parent().z_index - 2
		snapTo.hide()
		update_state_characteristics()
		GlobalStatesManager.CurrentModuleAtMouse.snapTo = null
		GlobalStatesManager.CurrentModuleAtMouse = null
	elif event.is_action_pressed("Cancel_Action") && GlobalStatesManager.CurrentModuleAtMouse != null:
		GlobalStatesManager.CurrentModuleAtMouse.queue_free()
		GlobalStatesManager.CurrentModuleAtMouse.snapTo = null
		GlobalStatesManager.CurrentModuleAtMouse = null

func update_walls():
	if GlobalStatesManager.ZOOM_OUT_STATE == true:
		WallAnimatorObject.play("Fade_In")
		RightEndObject.get_node("Sprite2D").texture = GreenOpenEndIcon
		LeftEndObject.get_node("Sprite2D").texture = GreenOpenEndIcon
	elif GlobalStatesManager.ZOOM_OUT_STATE == false:
		WallAnimatorObject.play("Fade_Out")
		RightEndObject.get_node("Sprite2D").texture = null
		LeftEndObject.get_node("Sprite2D").texture = null


func update_state_characteristics():
	if MODULE_STATE == 1:
		GlobalStatesManager.CurrentModuleAtMouse = self
		modulate = Color ("d800255f")
		LeftEndObject.hide()
		RightEndObject.hide()
	elif MODULE_STATE == 2:
		modulate = Color ("187d0048")
	elif MODULE_STATE == 3:
		modulate = Color ("ffffff")
		LeftEndObject.show()
		RightEndObject.show()
		if snapTo != null:
			if snapTo.name == RightEndObject.name:
				GlobalStatesManager.CurrentModuleAtMouse.LeftEndObject.hide()
				GlobalStatesManager.RightMostOpenEnd = RightEndObject
			elif snapTo.name == LeftEndObject.name:
				GlobalStatesManager.CurrentModuleAtMouse.RightEndObject.hide()
				GlobalStatesManager.LeftMostOpenEnd = LeftEndObject


func _on_mouse_entered_right_end():
	if GlobalStatesManager.CurrentModuleAtMouse != null:
		GlobalStatesManager.CurrentModuleAtMouse.snapTo = RightEndObject
		GlobalStatesManager.CurrentModuleAtMouse.MODULE_STATE = 2
		GlobalStatesManager.CurrentModuleAtMouse.update_state_characteristics()


func _on_mouse_exited_right_end():
	if GlobalStatesManager.CurrentModuleAtMouse != null:
		GlobalStatesManager.CurrentModuleAtMouse.MODULE_STATE = 1
		GlobalStatesManager.CurrentModuleAtMouse.snapTo = null
		GlobalStatesManager.CurrentModuleAtMouse.update_state_characteristics()


func _on_mouse_entered_left_end():
	if GlobalStatesManager.CurrentModuleAtMouse != null:
		GlobalStatesManager.CurrentModuleAtMouse.snapTo = LeftEndObject
		GlobalStatesManager.CurrentModuleAtMouse.MODULE_STATE = 2
		GlobalStatesManager.CurrentModuleAtMouse.update_state_characteristics()


func _on_mouse_exited_left_area():
	if GlobalStatesManager.CurrentModuleAtMouse != null:
		GlobalStatesManager.CurrentModuleAtMouse.MODULE_STATE = 1
		GlobalStatesManager.CurrentModuleAtMouse.snapTo = null
		GlobalStatesManager.CurrentModuleAtMouse.update_state_characteristics()

