extends AudioStreamPlayer2D

func play_hit_sound():
	pitch_scale = randf_range(0.9,1.1)
	play()
