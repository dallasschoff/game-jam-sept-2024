shader_type canvas_item;

varying vec2 world_position;
uniform vec2 player_position;

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

void vertex() {
	// Called for every vertex the material is visible on.
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	
	vec2 wpUV = world_position.xy;
	float radius = 40.5;
	
	COLOR = blue; //vec4(0.02,0.122,0.224,1);
	// Called for every pixel the material is visible on.
	if (distance(wpUV,player_position) < radius) {
		COLOR = vec4(1,1,1,0);
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
//
