extends Camera2D


@export var strenght:float = 2.0
@export var fade: float = 5.0

var ramdomnumber  = RandomNumberGenerator.new()

var shake_strenght: float = 0.0

func _ready() -> void:
	PlayerDeathManager.save_player_camera(self)
	
func _process(delta: float) -> void:
	
	if shake_strenght > 0.0:
		shake_strenght = lerpf(shake_strenght,0,fade*delta)
		var new_offset := Vector2(ramdomnumber.randf_range(-shake_strenght,shake_strenght),
		ramdomnumber.randf_range(-0.5*shake_strenght,0.5*shake_strenght))
		self.offset = new_offset

func shake(new_strenght:float):
	
	shake_strenght = new_strenght
