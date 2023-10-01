shader_type canvas_item;

uniform float movement_speed = 0.1;

void fragment() {
	COLOR = texture(TEXTURE, vec2(UV.x + TIME  * movement_speed, UV.y));
	
}
