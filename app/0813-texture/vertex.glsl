varying vec2 a, b;
void main() {
	b = uv;
	vec3 c, d, e, f;
	c = normalize(vec3(modelViewMatrix * vec4(position, 1)));
	d = normalize(normalMatrix * normal);
	e = position;
	f = reflect(c, d);
	float g = 2. * sqrt(pow(f.x, 2.) + pow(f.y, 2.) + pow(f.z + 1., 2.));
	a = f.xy / g + .5;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(e, 1);
}
