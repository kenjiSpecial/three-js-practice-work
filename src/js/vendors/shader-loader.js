var ShaderLoader = function(baseURL) {
	this.baseURL = `./${baseURL}` || '.';
	this.shaders = {};
};

ShaderLoader.prototype = {
	files: [],
	urls: [],
	loadedFile : 0,
	loaded     : null,
	setFile: function(url,  name) {
		var urlObj = {
			url: url,
			name: name
		};

		this.urls.push(urlObj);
	},

	load: function() {
		console.log(this.urls);
		this.urls.forEach(function(element) {
			$.ajax({
				url: `${this.baseURL}/${element.url}`,
				dateType: 'text',
				complete: function(event) {
					this.shaders[element.name] = event.responseText;
					this.loadedHandler();
				}.bind(this)
			});
		}.bind(this));
	},

	loadedHandler : function(){
		this.loadedFile++;

		if(this.loadedFile == this.urls.length){
			if(this.loaded) this.loaded();
		}
	}
};


module.exports = ShaderLoader;
