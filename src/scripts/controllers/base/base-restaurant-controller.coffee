define [
  'controllers/base/controller'
  'mediator'
  'lib/utils'
  'models/base/model'
], (
  Controller
  Mediator
  utils
  Model
) ->
  'use strict'

  class BaseRestaurantController extends Controller
   
    beforeAction: (params, route)->
      super
      restaurantId = utils.base64_decode(params['id']) if params['id']