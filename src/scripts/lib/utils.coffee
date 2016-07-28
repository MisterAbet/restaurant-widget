define [
  'underscore'
  'chaplin'
], (_, Chaplin) ->
  'use strict'

  # Application-specific utilities
  # ------------------------------

  # Delegate to Chaplin’s utils module
  utils = Chaplin.utils.beget Chaplin.utils

  # Add additional application-specific properties and methods
  _formatTime = (seconds)->
    hour = seconds/60>>0
    second = (seconds - (hour*60)) + ""
    if second.length < 2
      second =  second + "0"
    hour + ":" + second

  _(utils).extend
  #   someProperty: 'foo'
     base64_decode: (value)-> unescape(decodeURIComponent(atob(value)))
     base64_encode: (value)-> btoa(encodeURIComponent(escape(value)))

     centerImageOnHeight: (h,i)->
        img=$(i)
        img.on "load", ()->
          topMargin=(h-img.height())/2
          img.css("margin-top",topMargin)
          # img.parent().find(".price").css("right", img.height() / h + img.width() - 50)

     showAlert: (message,title,btn, callback)->
      if (typeof cordova isnt 'undefined' || typeof phonegap isnt 'undefined')
        navigator.notification.alert(message , callback , title, btn)
      else
        alert(message)
        if(typeof callback is "function") #TODO: check this
          callback()

     showConfirm: (message, title, btns, confirm_callback)->
      if (typeof cordova isnt 'undefined' || typeof phonegap isnt 'undefined')
        navigator.notification.confirm(message , confirm_callback , title, btns)
      else
        if(confirm(message) && typeof confirm_callback is "function")
            confirm_callback(1)

     showToast: (message, duration, position)->
        try
            window.plugins.toast.show message, duration, position
        catch error
            alert message
            
      checkWorkTime: (time, schedule) ->
        week = [
          'SUNDAY'
          'MONDAY'
          'TUESDAY'
          'WEDNESDAY'
          'THURSDAY'
          'FRIDAY'
          'SATURDAY'
        ]
        date = new Date(time);
        day = week[date.getDay()]
        workDay = false
        workTime = false
        openTime = null
        closeTime = null
        try
          workDay = schedule[day]?
          if workDay
            checkTime = date.getHours() * 60 + date.getMinutes()
            workTime = checkTime >= schedule[day].openTime and checkTime < schedule[day].closeTime
            openTime = _formatTime(schedule[day].openTime)
            closeTime = _formatTime(schedule[day].closeTime)
        catch e
          console.log e
        rval = 
          workDay : workDay
          workTime: workTime
          openTime: openTime
          closeTime: closeTime
        rval

      getFormattedDate: (date)->
        month = date.getMonth()+1
        if month <=9
          month="0" + month
        day = date.getDate()
        if day <= 9
          day= "0" + day;
        year = date.getFullYear()
        return (day + "/" + month + "/" + year)
  utils
