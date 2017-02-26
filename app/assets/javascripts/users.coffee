# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    flag = false
    $("button[data-toggle]").click ->
        target = $("." + $("button[data-toggle]").data("toggle"))
        if flag == false
            target.show()
            flag = true
        else
            target.hide()
            flag = false
