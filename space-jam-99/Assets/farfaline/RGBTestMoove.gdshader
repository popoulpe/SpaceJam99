shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_burley, specular_schlick_ggx;

const vec3 ign = vec3(0.06711056f, 0.00583715f, 52.9829189f);
uniform float alpha : hint_range(0,1);
uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;
uniform vec2 Speed;
uniform float SpeedHueShift: hint_range(0, 3, 0.1); 
uniform float point_size : hint_range(0.1, 128.0, 0.1);

uniform float roughness : hint_range(0.0, 1.0);
uniform sampler2D texture_metallic : hint_default_white, filter_linear_mipmap, repeat_enable;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_roughness_r, filter_linear_mipmap, repeat_enable;

uniform float specular : hint_range(0.0, 1.0, 0.01);
uniform float metallic : hint_range(0.0, 1.0, 0.01);

uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;
uniform float hue_shift: hint_range(0.0, 1.0) = 0.0;

vec4 shift_hue(in vec4 color, in float shift) {
	// The unit gray vector in RGB color space.
	vec3 gray = vec3(0.57735);
	// Project color onto gray axis.
	vec3 projection = gray * dot(gray, color.rgb);
	// Vector from gray axis to original color.
	vec3 U = color.rgb - projection;
	// Vector perpendicular to gray axis and U.
	vec3 V = cross(gray, U);
	// Rotate U and V around the gray axis.
	vec3 shifted = U * cos(shift * 2.0 * PI) + V * sin(shift * 2.0 * PI) + projection;
	return vec4(shifted, color.a);
}
void vertex() {
	UV = UV * uv1_scale.xy + uv1_offset.xy;
}

void fragment() {
	vec2 base_uv = UV + Speed * TIME ;

	vec4 albedo_tex = texture(texture_albedo, base_uv);
	ALBEDO = shift_hue(albedo,TIME*SpeedHueShift).rgb * albedo_tex.rgb;
	if (alpha < 0.001 || alpha < fract(ign.z * fract(dot(FRAGCOORD.xy, ign.xy * (sin(TIME*Speed.g)*0.012+1.0))))) {
		discard;
}

	float metallic_tex = dot(texture(texture_metallic, base_uv), metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	SPECULAR = specular;

	vec4 roughness_texture_channel = vec4(1.0, 0.0, 0.0, 0.0);
	float roughness_tex = dot(texture(texture_roughness, base_uv), roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;
}