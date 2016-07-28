define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model, TraceService) ->

  class Collection extends Chaplin.Collection
    # Mixin a synchronization state machine.
    _(@prototype).extend Chaplin.SyncMachine
    initialize: ->
      super
      #@on 'request', @beginSync
      #@on 'sync', @finishSync
      @on 'error', @onError

    # Use the project base model per default, not Chaplin.Model.
    model: Model

    _comparators: {
      asc: (a, b)->
        a = a.get(@_sort_key)
        b = b.get(@_sort_key)

        return 0 if a == b
        if a > b then 1 else -1

      desc: (a, b)->
        a = a.get(@_sort_key)
        b = b.get(@_sort_key)

        return 0 if a == b
        if a < b then 1 else -1
    }

    sort_by: (options)->
      @_sort_key = options['field']
      @comparator = @_comparators[options['direction']]
      @sort()

    # Place your application-specific collection features here.
    onError: (collection, resp, options) ->
      null