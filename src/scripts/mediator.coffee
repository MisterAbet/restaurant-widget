define [
  'chaplin'
  'models/api-model'
  'models/base/model'
], (
  Chaplin
  ApiModel
  Model
)->

  Chaplin.mediator._storage = {}

  Chaplin.mediator.store = (key, value)->
    Chaplin.mediator._storage[key] = value

  Chaplin.mediator.restore = (key)->
    Chaplin.mediator._storage[key]

  Chaplin.mediator.api_model = new ApiModel()
     
  Chaplin.mediator