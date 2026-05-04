shader_type spatial;

uniform sampler2D main_tex;
uniform float max_dist = 5;
uniform float min_dist = -10;
uniform float res_high = 16.0;
uniform float res_low = 2.0;

void vertex () {
	float distance = abs((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).z);
	vec3 low_tex = vec3(1.0,0.0,0.0);
	vec3 hi_tex = vec3(0.0,0.0,1.0);
	//ALBEDO = mix(hi_tex, low_tex, smoothstep(min_dist, max_dist, distance(a.xyz, world_camera)));
	//COLOR = vec4(distance / max_dist);
	COLOR = vec4(mix(hi_tex, low_tex, smoothstep(min_dist, max_dist, distance)),1.0);
	ALBEDO = vec3(1.0,0.0,0.0);
}

void fragment () {
	//vec3 world_camera = (INV_VIEW_MATRIX * vec4(vec3(0.0), 1.0)).xyz;
	//vec4 a = INV_VIEW_MATRIX * vec4(VERTEX, 1.0);
	//vec3 low_tex = texture(main_tex, UV * res_low).rgb;
	//low_tex = vec3(1.0,0.0,0.0);
	//vec3 hi_tex = texture(main_tex, UV * res_high).rgb;
	//hi_tex = vec3(0.0,1.0,0.0);
	//ALBEDO = mix(hi_tex, low_tex, smoothstep(min_dist, max_dist, distance(a.xyz, world_camera)));
}