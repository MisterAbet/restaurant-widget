define [
  'services/storage-service'
  'handlebars'
  'chaplin'
  'lib/view-helper' # Just load the view helpers, no return value
], (
  StorageService
  Handlebars
  Chaplin
) ->
  'use strict'

  class View extends Chaplin.View
    autoRender: true

    _redirectTo: (e)->
      href = $(e.currentTarget).data('href')
      if href
        location.href = href

    initialize: ->
      unless Modernizr.touch
        self=@
        processEvent= (e,d)->
          return unless d
          eSplited=e.split(" ")
          return unless eSplited[0].indexOf("tap")>-1
          self.events["click " + eSplited.slice(1).join(" ")]=d
          delete self.events[e]
        (processEvent(event,delegate) for event,delegate of @events)
      super

    getTemplateFunction: ->
      template = @template

      if typeof template is 'string'
        templateFunc = Handlebars.compile template
        @constructor::template = templateFunc
      else
        templateFunc = template

      templateFunc

    getTemplateData: ->
      templateData = super
      if @templateHelpers
        _.extend templateData, @templateHelpers
      templateData


