extends Node

#Change these variables from other scripts or systems
@export var ZOOM_OUT_STATE : bool = false #false means zoomed in, true means zoomed out

#Following are empty variables, waiting for their corresponding objects to assign themselves upon ready
var ZoomingCameraObject : Object


#In order to optimize performance, we only call update functions if their states have been changed instead of calling every frame
func _process(delta):
	if ZOOM_OUT_STATE != ZoomingCameraObject.actualZoomOutState:
		update_zoom_state()


#Calls relevant function in ZoomingCameraObject based on ZOOM_OUT_STATE
func update_zoom_state():
	print ("called")
	if ZOOM_OUT_STATE == false:
		ZoomingCameraObject.zoom_in_function()
	elif ZOOM_OUT_STATE == true:
		ZoomingCameraObject.zoom_out_function()
