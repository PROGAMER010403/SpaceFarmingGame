extends Node

#Change these variables from other scripts or systems
@export var ZOOM_OUT_STATE : bool = true #false means zoomed in, true means zoomed out

#Following are empty variables, waiting for their corresponding objects to assign themselves upon ready
var ZoomingCameraObject : Object
var CurrentModuleAtMouse : Object
var RightMostOpenEnd : Object
var LeftMostOpenEnd : Object

#Do not change these variables externally, these are used for optimization purposes to avoid constant update checks in dependant scripts
var isZoomStateJustChanged : bool = false


#In order to optimize performance, we only call update functions if their states have been changed instead of calling every frame
func _process(delta):
	if ZoomingCameraObject != null:
		if ZOOM_OUT_STATE != ZoomingCameraObject.actualZoomOutState:
			isZoomStateJustChanged = true
			update_zoom_state()
		elif ZOOM_OUT_STATE == ZoomingCameraObject.actualZoomOutState && isZoomStateJustChanged == true:
			isZoomStateJustChanged = false


#Calls relevant function in ZoomingCameraObject based on ZOOM_OUT_STATE
func update_zoom_state():
	if ZOOM_OUT_STATE == false:
		ZoomingCameraObject.zoom_in_function()
	elif ZOOM_OUT_STATE == true:
		ZoomingCameraObject.zoom_out_function()
