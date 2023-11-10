shader_type canvas_item;

uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {

	float modded_progress = progress;
	float x_progress = progress * 30.0;

	
	float x_shift = (float(int(UV.y * 20.0) % 2) - 0.5) * 0.05;
	x_shift = x_shift * progress;
    vec4 wave_color = texture(TEXTURE, vec2(UV.x + x_shift, UV.y));

	int x_remainder = int(UV.x * 200.0) % 10;
	int y_remainder = int(UV.y * 200.0) % 10;
	if (x_remainder != 0 && y_remainder != 0) {
		modded_progress = 0.0;
	}
	vec4 target_color = mix(wave_color, vec4(color,wave_color.a), modded_progress);
	
	COLOR = target_color;
}
