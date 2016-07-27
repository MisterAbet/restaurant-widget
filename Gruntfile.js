'use strict';
var LIVERELOAD_PORT = 35729;
var SERVER_PORT = 9001;
//var SERVER_ADDRESS = '0.0.0.0';
var SERVER_ADDRESS = 'localhost';
var lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT});
var mountFolder = function (connect, dir) {
    return connect.static(require('path').resolve(dir));
};

module.export = function(grunt){
	// show elapsed time at the end
    require('time-grunt')(grunt);
    // load all grunt tasks
    require('load-grunt-tasks')(grunt);

    // configurable paths
    var yeomanConfig = {
        app: 'src',
        dist: 'dist'
    };

    grunt.initConfig({
        yeoman: yeomanConfig
    });

    grunt.registerTask('default', []);
}