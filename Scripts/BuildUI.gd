extends Control

@onready var RootNode = get_parent().get_parent()


func _process(delta):
	if GlobalStatesManager.isZoomStateJustChanged:
		if GlobalStatesManager.ZOOM_OUT_STATE == true:
			show()
		elif GlobalStatesManager.ZOOM_OUT_STATE == false:
			hide()


func _on_farming_module_pressed():
	if GlobalStatesManager.CurrentModuleAtMouse == null:
		RootNode.place_module(1)



func _on_turret_module_1_pressed():
	if GlobalStatesManager.CurrentModuleAtMouse == null:
		RootNode.place_module(2)
