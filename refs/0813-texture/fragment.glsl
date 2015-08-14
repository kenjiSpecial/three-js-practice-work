uniform sampler2D tMatCap, tMap;
uniform float time;
varying vec2 a, b;
vec3 S(vec3 c) {
	return c - floor(c * (1. / 289.)) * 289.;
}
vec4 S(vec4 c) {
	return c - floor(c * (1. / 289.)) * 289.;
}
vec4 T(vec4 c) {
	return S((c * 34. + 1.) * c);
}
vec4 U(vec4 c) {
	return 1.79284291400159 - .85373472095314 * c;
}
vec3 V(vec3 c) {
	return c * c * c * (c * (c * 6. - 15.) + 10.);
}
float W(vec3 c) {
	vec3 d, e, f, g, w, x, y, z, A, B, C, D, O;
	d = floor(c);
	e = d + vec3(1);
	d = S(d);
	e = S(e);
	f = fract(c);
	g = f - vec3(1);
	vec4 h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, E, F, P;
	h = vec4(d.x, e.x, d.x, e.x);
	i = vec4(d.yy, e.yy);
	j = d.zzzz;
	k = e.zzzz;
	l = T(T(h) + i);
	m = T(l + j);
	n = T(l + k);
	o = m * (1. / 7.);
	p = fract(floor(o) * (1. / 7.)) - .5;
	o = fract(o);
	q = vec4(.5) - abs(o) - abs(p);
	r = step(q, vec4(0));
	o -= r * (step(0., o) - .5);
	p -= r * (step(0., p) - .5);
	s = n * (1. / 7.);
	t = fract(floor(s) * (1. / 7.)) - .5;
	s = fract(s);
	u = vec4(.5) - abs(s) - abs(t);
	v = step(u, vec4(0));
	s -= v * (step(0., s) - .5);
	t -= v * (step(0., t) - .5);
	w = vec3(o.x, p.x, q.x);
	x = vec3(o.y, p.y, q.y);
	y = vec3(o.z, p.z, q.z);
	z = vec3(o.w, p.w, q.w);
	A = vec3(s.x, t.x, u.x);
	B = vec3(s.y, t.y, u.y);
	C = vec3(s.z, t.z, u.z);
	D = vec3(s.w, t.w, u.w);
	E = U(vec4(dot(w, w), dot(y, y), dot(x, x), dot(z, z)));
	w *= E.x;
	y *= E.y;
	x *= E.z;
	z *= E.w;
	F = U(vec4(dot(A, A), dot(C, C), dot(B, B), dot(D, D)));
	A *= F.x;
	C *= F.y;
	B *= F.z;
	D *= F.w;
	float G, H, I, J, K, L, M, N, R;
	G = dot(w, f);
	H = dot(x, vec3(g.x, f.yz));
	I = dot(y, vec3(f.x, g.y, f.z));
	J = dot(z, vec3(g.xy, f.z));
	K = dot(A, vec3(f.xy, g.z));
	L = dot(B, vec3(g.x, f.y, g.z));
	M = dot(C, vec3(f.x, g.yz));
	N = dot(D, g);
	O = V(f);
	P = mix(vec4(G, H, I, J), vec4(K, L, M, N), O.z);
	vec2 Q = mix(P.xy, P.zw, O.y);
	R = mix(Q.x, Q.y, O.x);
	return 2.2 * R;
}
float X(float c, float d, float e) {
	float f, g, h;
	f = .1 * W(vec3(c, d, e) * 20.);
	g = .1 * W(vec3(.5, d, e) * 20.);
	h = smoothstep(.1, 0., c) + smoothstep(.9, 1., c);
	return mix(f, g, h);
}
void main() {
	vec3 c, d, f;
	c = vec3(0);
	d = texture2D(tMap, b).rgb;
	vec2 e = a + 2. * d.yz - vec2(.1);
	e += X(b.x, b.y, time * .3);
	f = texture2D(tMatCap, e).rgb;
	c += d * 1.4;
	c += .5 * f;
	gl_FragColor = vec4(c, 1);
}
