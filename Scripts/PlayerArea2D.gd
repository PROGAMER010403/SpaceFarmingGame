extends Area2D

@onready var InteractLabelObject = get_parent().get_node("InteractUI/InteractLabel")
@onready var AnimationPlayerObject = get_parent().get_node("InteractUI/AnimationPlayer")
@onready var ReqsLabel = get_parent().get_node("InteractUI/Panel/Panel2/InteractLabel2")

var defaultLabelText = "Press 'E' to "
var isInteractUIVisible : bool
var currentArea

func _input(event):
	if event.is_action_pressed("Key_E") && currentArea != null:
		interactAction(currentArea)


func _on_area_entered(area):
	if area.name == "HumanPodArea2DSmall":
		if area.get_parent().NotifUIObject.visible == true:
			if area.get_parent().POD_STATE == 1:
				AnimationPlayerObject.play("Fade_In")
				InteractLabelObject.text = defaultLabelText + "Grow Human"
				ReqsLabel.get_parent().show()
				ReqsLabel.text = "1 Food"
			elif area.get_parent().POD_STATE == 2 || area.get_parent().POD_STATE == 3:
				if area.get_parent().isFedLastCycle == false:
					AnimationPlayerObject.play("Fade_In")
					InteractLabelObject.text = defaultLabelText + "Feed Human"
					ReqsLabel.get_parent().show()
					ReqsLabel.text = "2 Food"
				elif area.get_parent().isFedLastCycle == true:
					AnimationPlayerObject.play("Fade_In")
					InteractLabelObject.text = defaultLabelText + "Harvest Human"
					ReqsLabel.get_parent().hide()
			elif area.get_parent().POD_STATE == 4:
				AnimationPlayerObject.play("Fade_In")
				InteractLabelObject.text = defaultLabelText + "Repair Pod"
				ReqsLabel.get_parent().show()
				ReqsLabel.text = "2 Materials"
			currentArea = area
	elif area.name == "FarmingArea2D":
		AnimationPlayerObject.play("Fade_In")
		InteractLabelObject.text = defaultLabelText + "Use Farm"
		ReqsLabel.get_parent().hide()
		currentArea = area


func _on_area_exited(area):
	if isInteractUIVisible == true:
		AnimationPlayerObject.play("Fade_Out")
		InteractLabelObject.text = defaultLabelText
		isInteractUIVisible = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Fade_In":
		isInteractUIVisible = true


func interactAction(object):
	object.get_parent().interacted()
	if isInteractUIVisible == true:
		if object.name == "HumanPodArea2DSmall":
			if object.get_parent().isReqsMet == true:
				AnimationPlayerObject.play("Fade_Out")
				InteractLabelObject.text = defaultLabelText
				isInteractUIVisible = false
			elif object.get_parent().isReqsMet == false:
				ReqsLabel.get_node("AnimationPlayer").play("Red")
		if object.name == "FarmingArea2D":
			AnimationPlayerObject.play("Fade_Out")
			InteractLabelObject.text = defaultLabelText
			isInteractUIVisible = false
