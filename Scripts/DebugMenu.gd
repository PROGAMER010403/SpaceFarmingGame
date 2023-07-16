extends VBoxContainer

@onready var RootNode = get_tree().get_root().get_node("Node2D")
@onready var ZoomInButton = $ZoomIn
@onready var ZoomOutButton = $ZoomOut
@onready var SpawnEnemiesButton = $SpawnEnemies
@onready var WaveIDCounter = $WaveID

var spawnData


func _ready():
	var jsonFile = FileAccess.open("res://Data/EnemySpawnData.json", FileAccess.READ)
	var fileContents = JSON.parse_string(jsonFile.get_as_text())
	jsonFile.close()
	
	spawnData = fileContents


func _process(delta):
	$CycleLabel.text = "Cycle: " + str(GlobalStatesManager.currentCycleCount)


func _on_zoom_in_pressed():
	GlobalStatesManager.ZOOM_OUT_STATE = false


func _on_zoom_out_pressed():
	GlobalStatesManager.ZOOM_OUT_STATE = true


func _on_spawn_enemies_pressed():
	var waveID = str(WaveIDCounter.value)
	var enemy1Spawns = spawnData[waveID].Enemy1Spawns
	var enemy2Spawns = spawnData[waveID].Enemy2Spawns
	var enemy3Spawns = spawnData[waveID].Enemy3Spawns
	var spawnSpacing = spawnData[waveID].SpawnSpacing
	
	RootNode.spawn_enemies(enemy1Spawns, enemy2Spawns, enemy3Spawns, spawnSpacing)


func _on_next_cycle_pressed():
	GlobalStatesManager.currentCycleCount += 1
	GlobalStatesManager.produce_resources()
	$CycleLabel.text = "Cycle: " + str(GlobalStatesManager.currentCycleCount)
	GlobalStatesManager.GoalHUDObject.update_resources()


func _on_prev_cycle_pressed():
	GlobalStatesManager.currentCycleCount -= 1
	$CycleLabel.text = "Cycle: " + str(GlobalStatesManager.currentCycleCount)


func _on_farm_phase_pressed():
	GlobalStatesManager.PHASE_STATE = 1


func _on_build_phase_pressed():
	GlobalStatesManager.PHASE_STATE = 2


func _on_wave_phase_pressed():
	GlobalStatesManager.PHASE_STATE = 3


func _on_add_food_pressed():
	GlobalStatesManager.currentFoodResource += $AddAmount.value
	GlobalStatesManager.GoalHUDObject.update_resources()


func _on_add_materials_pressed():
	GlobalStatesManager.currentMaterialsResource += $AddAmount.value
	GlobalStatesManager.GoalHUDObject.update_resources()
