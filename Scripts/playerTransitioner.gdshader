shader_type canvas_item;
varying vec2 world_position;
uniform vec2 player_position;
uniform float transition_radius;

void vertex() {
	// Called for every vertex the material is visible on.
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 wpUV = world_position.xy;
	float radius = transition_radius;
	float player_radius = radius;
	float player_radius2 = radius + 4.0;
	float player_radius3 = radius + 8.0;
	if (distance(wpUV,player_position) < player_radius3 && ((mod(wpUV.x - player_position.x,2.0)<1.0)&&(mod(wpUV.y - player_position.y,2.0))<1.0)) {
		COLOR = vec4(1,1,1,0);
	}

	//if (distance(wpUV,player_position) < radius2 && (mod((wpUV.x - wpUV.y + player_position.x - player_position.y),3)<1.0)) {
	if (distance(wpUV,player_position) < player_radius2 && ((mod(wpUV.x - player_position.x,2.0)<1.0) || (mod(wpUV.y - player_position.y,2.0))<1.0)) {
		COLOR = vec4(1,1,1,0);
	}
	
	if (distance(wpUV,player_position) < radius) {
		COLOR = vec4(1,1,1,0);
	}
}
