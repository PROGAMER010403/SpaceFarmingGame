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


