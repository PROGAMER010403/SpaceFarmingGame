extends Node2D

@onready var RootNode = get_tree().get_root().get_node("Node2D")

var FarmingModulePrefab = preload("res://Prefabs/farming_module.tscn")
var Turret1ModulePrefab = preload("res://Prefabs/turret_1_module.tscn")

var Enemy1Prefab = preload("res://Prefabs/enemy_1_placeholder.tscn")
var Enemy2Prefab = preload("res://Prefabs/enemy_2_placeholder.tscn")
var Enemy3Prefab = preload("res://Prefabs/enemy_3_placeholder.tscn")

func _ready():
	$CoreModule.MODULE_STATE = 3
	GlobalStatesManager.RightMostOpenEnd = $CoreModule/Container/RightEnd
	GlobalStatesManager.LeftMostOpenEnd = $CoreModule/Container/LeftEnd


func place_module(moduleID):
	if moduleID == 1:
		var ModuleInstance = FarmingModulePrefab.instantiate()
		ModuleInstance.name = "FarmingModule"
		ModuleInstance.MODULE_STATE = 1
		add_child(ModuleInstance)
	elif moduleID == 2:
		var ModuleInstance = Turret1ModulePrefab.instantiate()
		ModuleInstance.name = "Turret1Module"
		ModuleInstance.MODULE_STATE = 1
		add_child(ModuleInstance)


func spawn_enemies(enemy1, enemy2, enemy3, spacing):
	for i in range(enemy1):
		await get_tree().create_timer(float(spacing)).timeout
		instantiate_enemy(1, pick_spawn_point())
	for i in range(enemy2):
		await get_tree().create_timer(float(spacing)).timeout
		instantiate_enemy(2, pick_spawn_point())
	for i in range(enemy3):
		await get_tree().create_timer(float(spacing)).timeout
		instantiate_enemy(3, pick_spawn_point())


func pick_spawn_point():
	var spawnPositionIndex = randi() % 2 + 1
	var spawnPosition : Vector2
	if spawnPositionIndex == 1:
		spawnPosition = GlobalStatesManager.RightMostOpenEnd.global_position
		print ("right")
	elif spawnPositionIndex == 2:
		print ("left")
		spawnPosition = GlobalStatesManager.LeftMostOpenEnd.global_position
	
	return spawnPosition


func instantiate_enemy(enemyIndex, spawnPosition):
	var newEnemy1Instance
	if enemyIndex == 1:
		newEnemy1Instance = Enemy1Prefab.instantiate()
	elif enemyIndex == 2:
		newEnemy1Instance = Enemy2Prefab.instantiate()
	elif enemyIndex == 3:
		newEnemy1Instance = Enemy3Prefab.instantiate()
	
	newEnemy1Instance.global_position = spawnPosition
	RootNode.add_child(newEnemy1Instance)
