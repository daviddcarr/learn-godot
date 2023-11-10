shader_type canvas_item;

uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.01) = 0.0;

void fragment() {
	// Place fragment code here.
	//float test_variable = 0.1;
	float modded_progress = progress * 30.0;

	
	vec4 wave_color = texture(TEXTURE, vec2(UV.x + (sin(UV.y*modded_progress) * 0.02), UV.y));
	vec4 target_color = mix(wave_color, vec4(color,wave_color.a), progress);

	COLOR = target_color;
	//UV += vec2(sin(UV.y) * 0.1, UV.y);
	
	//COLOR = vec4(UV.x,UV.y,1,COLOR.a);
}
