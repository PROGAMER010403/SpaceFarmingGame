extends Control

@onready var RootNode = get_parent().get_parent()

var spawnData


func _ready():
	var jsonFile = FileAccess.open("res://Data/EnemySpawnData.json", FileAccess.READ)
	var fileContents = JSON.parse_string(jsonFile.get_as_text())
	jsonFile.close()
	
	spawnData = fileContents

func _process(delta):
	if GlobalStatesManager.isZoomStateJustChanged:
		if GlobalStatesManager.ZOOM_OUT_STATE == true:
			$VBoxContainer.show()
		elif GlobalStatesManager.ZOOM_OUT_STATE == false:
			$VBoxContainer.hide()

	if GlobalStatesManager.PHASE_STATE == 1:
		$VBoxContainer2.show()
		$VBoxContainer3.hide()
	if GlobalStatesManager.PHASE_STATE == 2:
		$VBoxContainer2.hide()
		$VBoxContainer3.show()
	if GlobalStatesManager.PHASE_STATE == 3:
		$VBoxContainer2.hide()
		$VBoxContainer3.hide()
		

func _on_farming_module_pressed():
	if GlobalStatesManager.CurrentModuleAtMouse == null && GlobalStatesManager.currentMaterialsResource >= 3:
		RootNode.place_module(1)
		GlobalStatesManager.currentMaterialsResource -= 3
		GlobalStatesManager.GoalHUDObject.update_resources()



func _on_turret_module_1_pressed():
	if GlobalStatesManager.CurrentModuleAtMouse == null:
		RootNode.place_module(2)


func _on_next_phase_pressed():
	GlobalStatesManager.PHASE_STATE = 2
	

func _on_spawn_enemies_pressed():
	GlobalStatesManager.PHASE_STATE = 3
	var waveID = str(GlobalStatesManager.currentWavesCount + 1)
	var enemy1Spawns = spawnData[waveID].Enemy1Spawns
	var enemy2Spawns = spawnData[waveID].Enemy2Spawns
	var enemy3Spawns = spawnData[waveID].Enemy3Spawns
	var spawnSpacing = spawnData[waveID].SpawnSpacing
	
	GlobalStatesManager.RootNodeObject.spawn_enemies(enemy1Spawns, enemy2Spawns, enemy3Spawns, spawnSpacing)


func _on_build_phase_pressed():
	GlobalStatesManager.currentCycleCount += 1
	GlobalStatesManager.produce_resources()
	GlobalStatesManager.GoalHUDObject.update_resources()
	GlobalStatesManager.PHASE_STATE = 1
	$VBoxContainer4.hide()
	
