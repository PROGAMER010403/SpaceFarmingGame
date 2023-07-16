extends Node

#Change these variables from other scripts or systems
@export var ZOOM_OUT_STATE : bool = true #false means zoomed in, true means zoomed out
@export var PHASE_STATE : int = 1 # 1 = Farm Phase | 2 = Build Phase | 3 = Wave Phase

var currentCycleCount : int = 1
var currentHumansCount : int = 0
var currentWavesCount : int = 0

var currentFoodResource : int = 1
var currentMaterialsResource : int = 3
var farmsMakingFood : int = 0
var farmsMakingMaterials : int = 0

#Following are empty variables, waiting for their corresponding objects to assign themselves upon ready
var ZoomingCameraObject : Object
var CurrentModuleAtMouse : Object
var RightMostOpenEnd : Object
var LeftMostOpenEnd : Object
var GoalHUDObject : Object
var RootNodeObject : Object

#Do not change these variables externally, these are used for optimization purposes to avoid constant update checks in dependant scripts
var isZoomStateJustChanged : bool = false
var knownCycleCount : int = 1

#In order to optimize performance, we only call update functions if their states have been changed instead of calling every frame
func _process(delta):
	
	if ZoomingCameraObject != null:
		if ZOOM_OUT_STATE != ZoomingCameraObject.actualZoomOutState:
			isZoomStateJustChanged = true
			update_zoom_state()
		elif ZOOM_OUT_STATE == ZoomingCameraObject.actualZoomOutState && isZoomStateJustChanged == true:
			isZoomStateJustChanged = false

	if PHASE_STATE == 1:
		ZOOM_OUT_STATE = true
	elif PHASE_STATE == 2:
		ZOOM_OUT_STATE = false

#Calls relevant function in ZoomingCameraObject based on ZOOM_OUT_STATE
func update_zoom_state():
	if ZOOM_OUT_STATE == false:
		ZoomingCameraObject.zoom_in_function()
	elif ZOOM_OUT_STATE == true:
		ZoomingCameraObject.zoom_out_function()


func produce_resources():
	currentFoodResource += farmsMakingFood * 3
	currentMaterialsResource += farmsMakingMaterials * 3
