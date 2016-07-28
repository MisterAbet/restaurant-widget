define [
  'chaplin'
], (Chaplin) ->

  class Model extends Chaplin.Model
    _.extend @prototype, Chaplin.SyncMachine

    initialize: ->
      super
      # TODO: fix problem with parse errors. May be zepto2backbone error def problem
      # @on "error",(m,e)->
      #   console.log "modelError!remember parse json error not showing correct here!",arguments
      @on 'request', @beginSync
      @on 'sync', @finishSync
      @on 'error', @unsync
      @on 'error', @onError

    onError: (model, resp, options) ->
      # response = JSON.parse resp.responseText
      @publishEvent 'error', null#resp.status + ': ' + response.error