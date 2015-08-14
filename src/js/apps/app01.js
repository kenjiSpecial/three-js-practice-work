window.$ = require('jquery');
var ShaderLoader = require('../vendors/shader-loader');

var shaderLoader = new ShaderLoader('0813-texture');
shaderLoader.setFile('fragment.glsl', 'fragment');
shaderLoader.setFile('vertex.glsl', 'vertex');
shaderLoader.loaded = loaded;
shaderLoader.load();

var renderer, sphereGeometry, sphereMaterial, sphere, scene, camera;
var CAMERA_ORBIT = 0.002,
    DISPLACEMENT = 0.04,
    SPRING_STRENGTH = 5e-4,
    DAMPEN = 0.997,
    ORIGIN = new THREE.Vector3(),
    DEPTH = 600;

var shaderUniforms = {
	tMatCap: {
		type: "t",
		value: THREE.ImageUtils.loadTexture("/images/matCap.jpg")
	},
	tMap: {
		type: "t",
		value: 0
	},
	time: {
		type: "f",
		value: 0
	}
};


function loaded() {
	init();
	animate();
}

function init(){
	renderer = new THREE.WebGLRenderer({
		canvas : document.getElementById('c'),
		antialias : true,
		alpha     : true
	});
	renderer.setSize( window.innerWidth, window.innerHeight );
	renderer.setClearColor(0xF0F0F);
	scene = new THREE.Scene();
	camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 5e3);
	scene.add(camera); //, createObjects(), createSprings(), bindCallbacks(), displaceRandomFace(), requestAnimationFrame(animate), framework.init();

	sphereGeometry = new THREE.SphereGeometry( 300, 60, 60 );
	sphereMaterial = new THREE.ShaderMaterial({
		uniforms       : shaderUniforms,
		vertexShader   : shaderLoader.shaders.vertex,
		fragmentShader : shaderLoader.shaders.fragment,
		shading        : THREE.SmoothShading
	});
	sphereMaterial.uniforms.tMatCap.value.wrapS = sphereMaterial.uniforms.tMatCap.value.wrapT = THREE.ClampToEdgeWrapping;
	sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
	sphere.geometry.dynamic = !0;
	sphere.position.y = 0;
	scene.add(sphere);

	createSprings();
}

function createSprings() {
	var sphereFaces = sphere.geometry.faces;
	for (var ii = 0; ii < sphereFaces.length; ii++) {
		var face = sphereFaces[ii];
		// console.log(face instanceof THREE.Face3);
		//face instanceof THREE.Ve
	}
}

function animate(){

}
