extends Control

@onready var HumanReqsContainer = $MarginContainer/HBoxContainer/HBoxContainer/HumanReqs
@onready var AlienThreatContainer = $MarginContainer/HBoxContainer/HBoxContainer/AlienThreat

@onready var FoodLabelObject = $MarginContainer/HBoxContainer/VBoxContainer/FoodLabel
@onready var MaterialsLabelObject = $MarginContainer/HBoxContainer/VBoxContainer/MaterialsLabel


func _ready():
	GlobalStatesManager.GoalHUDObject = self
	update_human_goals()
	update_wave_goals()
	update_resources()


func update_human_goals():
	if GlobalStatesManager.currentHumansCount <= 7:
		HumanReqsContainer.get_node("Label").text = "Human Requirements: " + str(GlobalStatesManager.currentHumansCount) + "/7"
		HumanReqsContainer.get_node("ProgressBar").value = GlobalStatesManager.currentHumansCount


func update_wave_goals():
	if GlobalStatesManager.currentWavesCount <= 5:
		AlienThreatContainer.get_node("Label").text = "Alien Waves Eliminated: " + str(GlobalStatesManager.currentWavesCount) + "/5"
		AlienThreatContainer.get_node("ProgressBar").value = GlobalStatesManager.currentWavesCount


func update_resources():
	FoodLabelObject.text  = "Food: " + str(GlobalStatesManager.currentFoodResource)
	MaterialsLabelObject.text = "Materials: " + str(GlobalStatesManager.currentMaterialsResource)


