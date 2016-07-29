define [
  'chaplin'
  'mediator'
  'imgcache'
  'layout'
], (
  Chaplin
  Mediator
  ImgCache
  Layout
) ->
  'use strict'

  class Application extends Chaplin.Application
    title: 'Restaurant widget'
    
    start: ->
      console.log 'Application start'
      # ImgCache.options.debug = true
      cacheInitOk = ()->
        console.log "ImgCacheInitOk"
      cacheInitError = ()->
        console.log "ImgCacheInitError"
      ImgCache.init(cacheInitOk, cacheInitError)
      # Mediator.trace.init()

      super
    
    initLayout: (options = {}) ->
      options.title ?= @title
      @layout = new Layout options