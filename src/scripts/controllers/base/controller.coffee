define [
  'chaplin'
  'lib/utils'
  'models/base/model'
  # 'views/shared/page-preloader-view'
  # 'views/shared/error-notify-view'
  # 'views/shared/spinner-view'
], (
  Chaplin
  utils
  Model
  # PagePreloaderView
  # ErrorNotifyView
  # SpinnerView
) ->
  'use strict'

  class Controller extends Chaplin.Controller

    showSpinner: false

    beforeAction: (params, route)->

      # if @showSpinner
      #   @mainview = new PagePreloaderView
      #     container: 'body'

      #   @mainview.subview 'error', new ErrorNotifyView()
      #   @mainview.subview 'spinner', new SpinnerView()
      #   @subscribeEvent 'main:view:before:render', () ->
      #     @mainview.removeSubview 'error'
      #     @mainview.removeSubview 'spinner'
      #     @mainview.dispose()
      
      # Chaplin.mediator.history.register route
      # @model = new Model()
      # @model.url = utils.base64_decode(params['href']) if params['href']