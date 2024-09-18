shader_type canvas_item;

varying float flicker;
varying vec2 world_position;
uniform vec2 player_position;
uniform float start_frame;
uniform float current_frame;
uniform float pulseSpeed;
const int burnable_count = 100;
uniform vec2[burnable_count] burnable_positions;
uniform bool[burnable_count] burnable_states;
uniform float[burnable_count] burnable_start_frames;
uniform float[burnable_count] burnable_radii;
uniform float[burnable_count] burnable_glow_speeds;
uniform vec2[2] pulse_positions;

uniform vec4 blue = vec4(0.02,0.122,0.224,1);
uniform vec4 purple = vec4(0.29,0.141,0.502,1);
uniform vec4 pink = vec4(0.773,0.227,0.616,1);
uniform vec4 cream = vec4(1,0.557,0.502,1);

//int colorMatch(vec4 col){
	//float blueDiff = abs(col.r - blue.r) + abs(col.g - blue.g) + abs(col.b - blue.b);
	//float purpleDiff = abs(col.r - purple.r) + abs(col.g - purple.g) + abs(col.b - purple.b);
	//float pinkDiff = abs(col.r - pink.r) + abs(col.g - pink.g) + abs(col.b - pink.b);
	//float creamDiff = abs(col.r - cream.r) + abs(col.g - cream.g) + abs(col.b - cream.b);
	//
	//float matchDiff = 0.9;
	//
	//if (blueDiff < matchDiff){
		//return 1;
	//} else if (purpleDiff < matchDiff){
		//return 2;
	//} else if (pinkDiff < matchDiff){
		//return 3;
	//} else if (creamDiff < matchDiff){
		//return 4;
	//} else {
		//return 3;
	//};
//}
float get_time() {
	return TIME;
}

void vertex() {
	// Called for every vertex the material is visible on.
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {

	vec2 wpUV = world_position.xy;
	flicker = sin(TIME*2.0)*1.0;
	float base_player_radius = 15.0;
	float player_radius = flicker + base_player_radius;
	float player_radius2 = flicker + base_player_radius + 4.0;
	float player_radius3 = flicker + base_player_radius + 8.0;
	float max_radius = 40.0;
	float frame_diff = current_frame-start_frame;
	float pulse_radius1 = min(frame_diff/pulseSpeed, flicker + max_radius);
	float pulse_radius2 = min(frame_diff/pulseSpeed, flicker + max_radius+4.0);
	float pulse_radius3 = min(frame_diff/pulseSpeed, flicker + max_radius+8.0);

	COLOR = blue; //vec4(0.02,0.122,0.224,1);

	// Player light---------------------------------
	if (distance(wpUV,player_position) < player_radius3 && ((mod(wpUV.x - player_position.x,2.0)<1.0)&&(mod(wpUV.y - player_position.y,2.0))<1.0)) {
		COLOR = vec4(1,1,1,0);
	}

	//if (distance(wpUV,player_position) < radius2 && (mod((wpUV.x - wpUV.y + player_position.x - player_position.y),3)<1.0)) {
	if (distance(wpUV,player_position) < player_radius2 && ((mod(wpUV.x - player_position.x,2.0)<1.0) || (mod(wpUV.y - player_position.y,2.0))<1.0)) {
		COLOR = vec4(1,1,1,0);
	}

	if (distance(wpUV,player_position) < player_radius) {
		COLOR = vec4(1,1,1,0);
	}
	//--------------------------------------------

	//Pulse light------------------------------------
	for (int i = 0; i < pulse_positions.length(); i++) {
		vec2 pulse_position = pulse_positions[i];
		if (i == 0) {
			if (distance(wpUV,pulse_position) < (flicker + max_radius+8.0) && ((mod(wpUV.x - pulse_position.x,2.0)<1.0)&&(mod(wpUV.y - pulse_position.y,2.0))<1.0)) {
				COLOR = vec4(1,1,1,0);
			}

			if (distance(wpUV,pulse_position) < (flicker + max_radius+4.0) && ((mod(wpUV.x - pulse_position.x,2.0)<1.0) || (mod(wpUV.y - pulse_position.y,2.0))<1.0)) {
				COLOR = vec4(1,1,1,0);
			}

			if (distance(wpUV,pulse_position) < (flicker + max_radius)) {
				COLOR = vec4(1,1,1,0);
			}
		} else {
			if (distance(wpUV,pulse_position) < pulse_radius3 && ((mod(wpUV.x - pulse_position.x,2.0)<1.0)&&(mod(wpUV.y - pulse_position.y,2.0))<1.0)) {
				COLOR = vec4(1,1,1,0);
			}

			if (distance(wpUV,pulse_position) < pulse_radius2 && ((mod(wpUV.x - pulse_position.x,2.0)<1.0) || (mod(wpUV.y - pulse_position.y,2.0))<1.0)) {
				COLOR = vec4(1,1,1,0);
			}

			if (distance(wpUV,pulse_position) < pulse_radius1) {
				COLOR = vec4(1,1,1,0);
			}
		}
	}

	//-------------------------------------------------

	//Burnable lights
	for (int i = 0; i < burnable_count; i++) {
		if (burnable_states[i] == true) {
			vec2 burnable_position = burnable_positions[i];
			float burnable_frame_diff = current_frame - burnable_start_frames[i];
			float burnable_radius1 = min(burnable_frame_diff/burnable_glow_speeds[i], flicker + burnable_radii[i]);
			float burnable_radius2 = min(burnable_frame_diff/burnable_glow_speeds[i], flicker + burnable_radii[i])+4.0;
			float burnable_radius3 = min(burnable_frame_diff/burnable_glow_speeds[i], flicker + burnable_radii[i])+8.0;
			if (distance(wpUV,burnable_position) < burnable_radius3 && ((mod(wpUV.x - burnable_position.x,2.0)<1.0)&&(mod(wpUV.y - burnable_position.y,2.0))<1.0)) {
				COLOR = vec4(1,1,1,0);
			}
			if (distance(wpUV,burnable_position) < burnable_radius2 && ((mod(wpUV.x - burnable_position.x,2.0)<1.0) || (mod(wpUV.y - burnable_position.y,2.0))<1.0)) {
				COLOR = vec4(1,1,1,0);
			}
			if (distance(wpUV,burnable_position) < burnable_radius1) {
				COLOR = vec4(1,1,1,0);
			}
		}
	}

	//switch (colorMatch(COLOR)) {
		//case 1:
			//COLOR = blue;
			//break;
		//case 2:
			//COLOR = purple;
			//break;
		//case 3:
			//COLOR = pink;
			//break;
		//case 4:
			//COLOR = cream;
			//break;
		//default:
			//break;
	//}
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
