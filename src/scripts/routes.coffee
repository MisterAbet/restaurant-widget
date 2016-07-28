define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is match method of the Router
  (match) ->
    match ''                           , 'restaurant#show'
        
    match 'restaurant/:id'                   , 'restaurant#show'
    
    