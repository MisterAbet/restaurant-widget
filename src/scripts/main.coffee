'use strict'

try 
  require.config
    shim:
      backbone:
        deps: ['underscore', 'jquery']
        exports: 'Backbone'
        
      'backbone.localStorage':
        deps: ['backbone']
        exports: 'Backbone.LocalStorage'
        
      handlebars:
        exports: 'Handlebars'

      jquery:
        exports: '$'

      underscore:
        exports: '_'
     
      imgcache:
        deps: ['jquery']
        exports: 'ImgCache'


    paths:
      jquery: '../bower_components/zepto-full/zepto'
      backbone: '../bower_components/backbone/backbone'
      'backbone.localStorage': '../bower_components/backbone.localStorage/backbone.localStorage'
      
      underscore: '../bower_components/lodash/dist/lodash.compat'
      handlebars: '../bower_components/handlebars/handlebars'

      chaplin: '../bower_components/chaplin/chaplin'
      ratchet: '../bower_components/ratchet/dist/js/ratchet'
      async: '../bower_components/requirejs-plugins/src/async'

      imgcache: '../bower_components/imgcache.js/js/imgcache'
      moment: '../bower_components/moment/moment'
      'crypto-js': '../bower_components/crypto-js/crypto-js'
      TraceKit: '../bower_components/tracekit/tracekit'

catch 
  {}

require [
  'application'
  'routes'
  'chaplin'
  'ratchet'
], (
  Application
  routes
  Chaplin
) ->
  init = () ->

    app = () ->
      new Application
        routes: routes
        controllerSuffix: '-controller'
        pushState: false

    _.delay app, 1000

  init()