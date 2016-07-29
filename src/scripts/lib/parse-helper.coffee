define [
  'chaplin'
], (
  Chaplin
) ->
  'use strict'

  class ParseHelper

    parseCustom=(data)->
      try
        JSON.parse(data)
      catch
        {}

    @getMenuFromServer: (menu, taxes)->
      # TODO: optimize me
      _.map menu,(category)->
        # console.log category.images
        category.poster = if category.images.length > 0 then Chaplin.mediator.api_model.apiPath() + "/"+ category.images[0] else 'images/category-poster.jpg'
        # console.log category.poster
        category.products=_.map category.products, (product)->
          customData=parseCustom(product.product.custom)
          delete product.product.custom
          if product.images? and product.images.length > 0
            product.photo = Chaplin.mediator.api_model.apiPath() + "/" + product.images[0]
          for image in product.images
            if(image.toLowerCase().indexOf("main.png")>-1)
              product.photo=Chaplin.mediator.api_model.apiPath()+"/"+image
          product = _.merge(product, customData)

          product.name = product.product.name
          product.id = product.product.identifier
          product.addedToCart = 0
          try
            # if product.id == 'PR-203'
            #   console.log product.product.netto, product.product.tax

            product.price = Math.round(product.product.netto * (_.where(taxes,
              identifier: product.product.tax)[0].vat/100 + 1))
          catch err
            console.log product
          product
        category

    @getRestaurantFromServer: (serverRestaurant, withDetails) ->
      restaurant = serverRestaurant
      restaurant.id = restaurant.country + restaurant.corporateId
      restaurant = _.merge restaurant, parseCustom(restaurant.custom)
      delete restaurant.custom

      # delete restaurant.averageBill

      restaurant.logo = Chaplin.mediator.api_model.restaurantLogoImage(restaurant.id) #"https://t.srv4pos.com/v14/"+restaurant.id+"/images/current/MAIN.png"
      restaurant.splash = Chaplin.mediator.api_model.restarantSplashImage(restaurant.id)
      restaurant=_.defaults restaurant,
          id: -1
          name: ""
          description: ""
          city: ""
          address: ""
          averageBill: 0
          logo: ""
          type: "spot"
          distance: "Not available"

      if withDetails
        images = restaurant.images
        restaurant.interierPhotos = []
        for image in images
          if image.toLowerCase().indexOf("interier") >- 1
            restaurant.interierPhotos.push Chaplin.mediator.api_model.apiPath() + "/" + image
        restaurant.mainImage = restaurant.interierPhotos[0]
        delete restaurant.images
        restaurant=_.defaults restaurant,
          workHours: ""
          workHoursWeek:{}
          phone: undefined
          payCard: undefined
          wifi: undefined
          deliveryTime: undefined
          deliveryCost: undefined
          menu : {}
        restaurant.menu = @getMenuFromServer restaurant.menu, restaurant.taxes
      restaurant
