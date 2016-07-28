define [
  'controllers/base/base-restaurant-controller'
  'models/base/model'
  'mediator'
  'lib/utils'
], (
  BaseRestaurantController
  Model
  Mediator
  utils
) ->
  'use strict'

  class RestaurantController extends BaseRestaurantController

    showSpinner: true

    show: (params, route) ->
      null