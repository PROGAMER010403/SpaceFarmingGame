extends Camera2D

@onready var ZoomAnimatorObject = $ZoomAnimator

@export var maxZoomLevel : float
@export var minZoomLevel : float

var actualZoomOutState : bool #false means zoomed in, true means zoomed out


#ZoomingCamera2D is made to define itself to the GlobalStatesManager singleton.
func _ready():
	GlobalStatesManager.ZoomingCameraObject = self


#Is called by GlobalStatesManager when ZOOM_OUT_STATE is false.
func zoom_in_function():
#	if zoom == Vector2(minZoomLevel, minZoomLevel):
		ZoomAnimatorObject.play("zoom_in_animation")
		actualZoomOutState = false


#Is called by GlobalStatesManager when ZOOM_OUT_STATE is true.
func zoom_out_function():
#	if zoom == Vector2(maxZoomLevel, maxZoomLevel):
		ZoomAnimatorObject.play("zoom_out_animation")
		actualZoomOutState = true
