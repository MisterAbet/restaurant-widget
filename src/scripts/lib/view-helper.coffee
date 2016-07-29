define [
  'handlebars'
  'chaplin'
  'lib/utils'
  'services/ordersHistory-service'
], (Handlebars, Chaplin, utils, OrdersHistoryService) ->
  'use strict'

  # Application-specific Handlebars helpers
  # ---------------------------------------

  # Get Chaplin-declared named routes. {{#url "like" "105"}}{{/url}}
  Handlebars.registerHelper 'url', (routeName, params..., options) ->
    utils.reverse routeName, params

  Handlebars.registerHelper 'historyBack', () ->
    Chaplin.mediator.history.backRoute()

  Handlebars.registerHelper 'url_base64', (routeName, params..., options) ->
    params = _.map params, (element)-> utils.base64_encode(element) if element
    utils.reverse routeName, params

  Handlebars.registerHelper 'url_path', (controller, action, params..., options) ->
    routeName = controller + '#' + action
    utils.reverse routeName, params

  Handlebars.registerHelper 'is_equal', (value1, value2, options) ->
    options.fn(this) if value1 == value2

  Handlebars.registerHelper 'if_not_equal', (value1, value2, options) ->
    options.fn(this) if value1 != value2

  Handlebars.registerHelper 'if_is_not_null', (value1, options) ->
    options.fn(this) if value1 && value1 != null && value1 != ''

  Handlebars.registerHelper 'if_is_not_empty', (values..., options) ->
    options.fn(this) if _.filter(values, (val) => val && val != null && val != '').length > 0

  Handlebars.registerHelper 'price', (value, currency) ->
    if value%100 == 0
      price = parseInt(value/ 100)
      if currency && _.isString(currency)
        price += ' ' + currency
    else
      price = parseInt(value/ 100) + "<i>.</i><small>" + Math.round((value% 100)) + "</small>"
      if currency && _.isString currency
        price += ' ' + currency
      price = new Handlebars.SafeString price
    price

  Handlebars.registerHelper 'distance', (value) ->
    if typeof value is "string"
      value
    else
      Math.round(value / 100) / 10 + " km"

  Handlebars.registerHelper 'phoneNumber', (value) ->
    if typeof value is 'string'
      value.replace /[^\d]+/ig, ''

  Handlebars.registerHelper 'ifEqual', (v1, v2, options)->
    if(v1 is v2)
      options.fn(this)
    else
      options.inverse(this)

  Handlebars.registerHelper 'boolToReadable', (v) ->
    if v
      "Yes"
    else
      "No"

  Handlebars.registerHelper 'objectWriter', (value)->
    html = ''
    _.each _.keys(value), (key)->
      html += key + ': ' + value[key] + '</br>'

    console.log html

    new Handlebars.SafeString html

  null
