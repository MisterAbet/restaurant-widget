define [
  'models/base/model'
  'config'
], (
  Model
  config
)->

  'use strict'

  class ApiModel extends Model

    apiPath:-> @get 'api_path'

    initialize:->
      @set 'api_path', 'https://' + config.server + '.srv4pos.com/v' + config.apiVersion

    restaurant: (id)->
      @get('api_path') + '/restaurants-overview/' + id

    booking: (id)->
      @get('api_path') + '/' + id + '/bookings'

    restaurantLogoImage: (id)->
      @get('api_path') + '/' + id + '/images/current/MAIN.png'

    restarantSplashImage: (id)->
        @get('api_path') + '/' + id + '/images/current/SPLASH.PNG'

    restaurantInterierImage: (id, num)->
      @get('api_path') + '/' + id + '/images/current/INTERIER_' + num + '.png'

    cartOrders: (id)->
      @get('api_path') + '/' + id + '/orders'

    serverTime: ->
      @get('api_path') + '/server/time'

    # ticketPayment: (sellerId, orderId)->
    #   @get('api_path') + '/dibs/payment/' + sellerId + '/' + orderId

    signAdyenData: (sellerId, orderId)->
      @get('api_path') + '/' + sellerId + '/orders/' + orderId + '/sign'