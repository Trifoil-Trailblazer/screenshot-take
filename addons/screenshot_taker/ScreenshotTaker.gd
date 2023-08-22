extends Node

# Screenshot key
@export var screenshot_key: Key = KEY_C


func screenshot():
	# Capture the screenshot
	var size = DisplayServer.window_get_size()
	var image = get_viewport().get_texture().get_image()

	# Setup path and screenshot filename
	var date = Time.get_datetime_dict_from_system()
	var path = "user://"
	var file_name = (
		"screenshot-%d-%02d-%02dT%02d:%02d:%02d"
		% [date.year, date.month, date.day, date.hour, date.minute, date.second]
	)
	var dir = DirAccess.open(path)

	if not dir.dir_exists(path + "screenshots/"):
		dir.make_dir(path + "screenshots/")
		dir = DirAccess.open(path + "screenshots/")
	else:
		dir = DirAccess.open(path + "screenshots/")

	# Find a filename that isn't taken
	var n = 1
	var file_path = path + "screenshots/" + file_name + ".png"
	while true:
		if dir.file_exists(file_path):
			file_path = path + "screenshots/" + file_name + "-" + str(n) + ".png"
			n = n + 1
		else:
			break

	print(file_path)
	# Save the screenshot
	image.flip_y()
	image.resize(size.x, size.y, Image.INTERPOLATE_NEAREST)
	image.save_png(file_path)


func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(screenshot_key):
		screenshot()
