'use strict';
var LIVERELOAD_PORT = 35729;
var SERVER_PORT = 9001;
//var SERVER_ADDRESS = '0.0.0.0';
var SERVER_ADDRESS = 'localhost';
var lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT});
var mountFolder = function (connect, dir) {
    return connect.static(require('path').resolve(dir));
};

module.exports = function (grunt){
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
        yeoman: yeomanConfig,
        clean: {
            dist: ['.tmp', '<%= yeoman.dist %>/*'],
            server: '.tmp'
        },
        watch: {
            options: {
                nospawn: true,
                livereload: true
            },
            coffee: {
                files: ['<%= yeoman.app %>/scripts/**/*.coffee'],
                //files: ['<%= yeoman.app %>/coffee/**/*.coffee'],
                tasks: ['coffee:dist']
            },
            coffeeTest: {
                files: ['test/spec/**/*.coffee'],
                tasks: ['coffee:test']
            },
            compass: {
                //files: ['<%= yeoman.app %>/styles/**/*.{scss,sass}'],
                files: ['<%= yeoman.app %>/scss/**/*.{scss,sass}'],
                tasks: ['compass']
            },
            livereload: {
                options: {
                    livereload: grunt.option('livereloadport') || LIVERELOAD_PORT
                },
                files: [
                    '<%= yeoman.app %>/*.html',
                    '{.tmp,<%= yeoman.app %>}/styles/**/*.css',
                    '{.tmp,<%= yeoman.app %>}/scripts/**/*.js',
                    '<%= yeoman.app %>/images/**/*.{png,jpg,jpeg,gif,webp}',
                    '<%= yeoman.app %>/scripts/templates/*.{ejs,mustache,hbs}',
                    'test/spec/**/*.js'
                ]
            },
            handlebars: {
                files: [
                    '<%= yeoman.app %>/scripts/templates/**/*.hbs'
                ],
                tasks: ['handlebars']
            },
            test: {
                files: ['<%= yeoman.app %>/scripts/**/*.js', 'test/spec/**/*.js'],
                tasks: ['test:true']
            }
        },
        connect: {
            options: {
                port: grunt.option('port') || SERVER_PORT,
                // change this to '0.0.0.0' to access the server from outside
                hostname: SERVER_ADDRESS
            },
            livereload: {
                options: {
                    middleware: function (connect) {
                        return [
                            lrSnippet,
                            mountFolder(connect, '.tmp'),
                            mountFolder(connect, yeomanConfig.app)
                        ];
                    }
                }
            },
            test: {
                options: {
                    port: 9001,
                    middleware: function (connect) {
                        return [
                            lrSnippet,
                            mountFolder(connect, '.tmp'),
                            mountFolder(connect, 'test'),
                            mountFolder(connect, yeomanConfig.app)
                        ];
                    }
                }
            },
            dist: {
                options: {
                    middleware: function (connect) {
                        return [
                            mountFolder(connect, yeomanConfig.dist)
                        ];
                    }
                }
            }
        },
        open: {
            server: {
                path: 'http://' + SERVER_ADDRESS + ':<%= connect.options.port %>'
            },
            test: {
                path: 'http://' + SERVER_ADDRESS + ':<%= connect.test.options.port %>'
            }
        },
        jshint: {
            options: {
                jshintrc: '.jshintrc',
                reporter: require('jshint-stylish')
            },
            all: [
                'Gruntfile.js',
                '<%= yeoman.app %>/scripts/**/*.js',
                '!<%= yeoman.app %>/scripts/vendor/*',
                'test/spec/**/*.js'
            ]
        },
        mocha: {
            all: {
                options: {
                    run: true,
                    src: ['http://' + SERVER_ADDRESS + ':<%= connect.test.options.port %>/index.html']
                }
            }
        },
        coffee: {
            dist: {
                files: [{
                    // rather than compiling multiple files here you should
                    // require them into your main .coffee file
                    expand: true,
                    cwd: '<%= yeoman.app %>/scripts',
                    //cwd: '<%= yeoman.app %>/coffee',
                    src: '**/*.coffee',
                    dest: '.tmp/scripts',
                    ext: '.js'
                }]
            },
            test: {
                files: [{
                    expand: true,
                    cwd: 'test/spec',
                    src: '**/*.coffee',
                    dest: '.tmp/spec',
                    ext: '.js'
                }]
            }
        },
        useminPrepare: {
            html: '<%= yeoman.app %>/index.html',
            options: {
                dest: '<%= yeoman.dist %>'
            }
        },
        compass: {
            options: {
                //sassDir: '<%= yeoman.app %>/styles',
                sassDir: '<%= yeoman.app %>/scss',
                cssDir: '.tmp/styles',
                imagesDir: '<%= yeoman.app %>/images',
                javascriptsDir: '<%= yeoman.app %>/scripts',
                fontsDir: '<%= yeoman.app %>/fonts',
                importPath: '<%= yeoman.app %>/bower_components',
                relativeAssets: true
            },
            dist: {},
            server: {
                options: {
                    debugInfo: true
                }
            }
        },
        requirejs: {
            dist: {
                // Options: https://github.com/jrburke/r.js/blob/master/build/example.build.js
                options: {
                    baseUrl: '.tmp/scripts',
                    optimize: 'none',
                    paths: {
                        'templates': '../../.tmp/scripts/templates',
                        'jquery': '../../<%= yeoman.app %>/bower_components/zepto-full/zepto', // PICKADATE not work correct with zepto
                        'underscore': '../../<%= yeoman.app %>/bower_components/lodash/dist/lodash.compat',
                        'backbone': '../../<%= yeoman.app %>/bower_components/backbone/backbone',
                        'backbone.localStorage': '../../<%= yeoman.app %>/bower_components/backbone.localStorage/backbone.localStorage',
                        'chaplin': '../../<%= yeoman.app %>/bower_components/chaplin/chaplin',
                        'ratchet': '../../<%= yeoman.app %>/bower_components/ratchet/dist/js/ratchet',
                        'handlebars': '../../<%= yeoman.app %>/bower_components/handlebars/handlebars',
                        'async': '../../<%= yeoman.app %>/bower_components/requirejs-plugins/src/async',
                        
                        'customevent-polyfill': '../../<%= yeoman.app %>/bower_components/customevent-polyfill/customevent-polyfill',
                        'imgcache':'../../<%= yeoman.app %>/bower_components/imgcache.js/js/imgcache',
                        'moment':'../../<%= yeoman.app %>/bower_components/moment/moment',
                        'crypto-js': '../../<%= yeoman.app %>/bower_components/crypto-js/crypto-js',
                        'TraceKit': '../../<%= yeoman.app %>/bower_components/tracekit/tracekit'
                    },
                    preserveLicenseComments: false,
                    useStrict: true,
                    include: [
                        'controllers/restaurant-controller'
                    ],
                    // out: '<%= yeoman.dist %>/main.js'
                }
            }
        },
        bower: {
            all: {
                rjsConfig: '<%= yeoman.app %>/scripts/main.js'
            }
        },
        handlebars: {
            compile: {
                options: {
                    namespace: 'JST',
                    amd: true
                },
                files: {
                    '.tmp/scripts/templates.js': ['<%= yeoman.app %>/scripts/templates/**/*.hbs']
                }
            }
        },
        rev: {
            dist: {
                files: {
                    src: [
                        '<%= yeoman.dist %>/scripts/**/*.js',
                        '<%= yeoman.dist %>/styles/**/*.css',
                        'bower_components/font-awesome/fonts/*.*',
                        '/styles/fonts/**/*.*'
                    ]
                }
            }
        },
        usemin: {
            html: ['<%= yeoman.dist %>/**/*.html'],
            css: ['<%= yeoman.dist %>/styles/**/*.css'],
            options: {
                dirs: ['<%= yeoman.dist %>']
            }
        },
        imagemin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '**/*.{png,jpg,jpeg}',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        cssmin: {
            dist: {
                files: {
                    '<%= yeoman.dist %>/styles/main.css': [
                        '.tmp/styles/**/*.css',
                        '<%= yeoman.app %>/styles/**/*.css',
                    ]
                }
            }
        },
        htmlmin: {
            dist: {
                options: {
                    /*removeCommentsFromCDATA: true,
                    // https://github.com/yeoman/grunt-usemin/issues/44
                    //collapseWhitespace: true,
                    collapseBooleanAttributes: true,
                    removeAttributeQuotes: true,
                    removeRedundantAttributes: true,
                    useShortDoctype: true,
                    removeEmptyAttributes: true,
                    removeOptionalTags: true*/
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    src: '*.html',
                    dest: '<%= yeoman.dist %>'
                }]
            }
        },
        copy: {
            dist: {
                files: [{
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '<%= yeoman.dist %>',
                    src: [
                        '*.{ico,txt}',
                        '.htaccess',
                        'images/**/*.*',
                        'fixtures/**/*.json',
                        'fonts/*.*',
                        'config.xml',
                        'icon.png'
                    ]
                }, {
                    //for font-awesome
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>/bower_components/font-awesome',
                    dest: '<%= yeoman.dist %>',
                    src: ['fonts/*.*']
                }, {
                    //for ratchet fonts
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>/bower_components/ratchet',
                    dest: '<%= yeoman.dist %>',
                    src: ['fonts/*.*']
                }]
            },
            server: {
                files: [{
                    //for font-awesome
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>/bower_components/font-awesome',
                    dest: '.tmp',
                    src: ['fonts/*.*']
                }, 
                {
                    //for ratchet fonts
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>/bower_components/ratchet',
                    dest: '.tmp',
                    src: ['fonts/*.*']
                },
                {
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '.tmp',
                    src: ['fonts/*.*']
                }]
            }
        }
    });

    grunt.registerTask('createDefaultTemplate', function () {
        grunt.file.write('.tmp/scripts/templates.js', 'this.JST = this.JST || {};');
    });

    grunt.registerTask('server', function (target) {
        grunt.log.warn('The `server` task has been deprecated. Use `grunt serve` to start a server.');
        grunt.task.run(['serve' + (target ? ':' + target : '')]);
    });

    grunt.registerTask('serve', function (target) {
        grunt.task.run([
            'clean:server',
            'copy:server',
            'coffee:dist',
            'createDefaultTemplate',
            'handlebars',
            'compass:server',
            'connect:livereload',
            'open:server',
            'watch'
        ]);
    });

    grunt.registerTask('test', function (isConnected) {
        isConnected = Boolean(isConnected);
        var testTasks = [
                'clean:server',
                'coffee',
                'createDefaultTemplate',
                'handlebars',
                'compass',
                'connect:test',
                'mocha',
            ];

        if(!isConnected) {
            return grunt.task.run(testTasks);
        } else {
            // already connected so not going to connect again, remove the connect:test task
            testTasks.splice(testTasks.indexOf('connect:test'), 1);
            return grunt.task.run(testTasks);
        }
    });

    grunt.registerTask('build', [
        'clean:dist',
        'coffee',
        'createDefaultTemplate',
        'handlebars',
        'compass:dist',
        'useminPrepare',
        'requirejs',
        'imagemin',
        'htmlmin',
        'concat',
        'cssmin',
        'uglify',
        'copy',
        'rev',
        'usemin'
    ]);

    grunt.registerTask('default', ['build']);
};