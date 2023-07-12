extends Node2D


var FarmingModulePrefab = preload("res://Prefabs/farming_module.tscn")
var Turret1ModulePrefab = preload("res://Prefabs/turret_1_module.tscn")


func _ready():
	$CoreModule.MODULE_STATE = 3


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

