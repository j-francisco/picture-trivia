({
	// appDir: 'js/bin',
	// baseUrl: ".",
	// dir: 'js/release',
	// modules: [
	// 	{
	// 		name: "app"
	// 	}
	// ],
	// paths: {
	// 	'jquery': '../lib/jquery',
	// 	'underscore': '../lib/underscore-min',
	// 	'backbone': '../lib/backbone-min',
	// 	'text': '../lib/text'
	// },
	baseUrl: 'js/bin',
	name: 'app',
	insertRequire: ['app'],
	out: './js/bin/main_app.js',
	paths: {
		'jquery': '../lib/jquery',
		'underscore': '../lib/underscore-min',
		'backbone': '../lib/backbone-min',
		'text': '../lib/text',
		'fastclick': '../lib/fastclick'
	}
})