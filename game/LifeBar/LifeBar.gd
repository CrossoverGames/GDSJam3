extends TextureProgress

export(float) var max_hp = 100

func _ready():
	set_max(max_hp)
	
func update_max_hp(value):
	set_max(value)
