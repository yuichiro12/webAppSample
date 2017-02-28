# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    flag = false
    $("button[data-toggle]").click ->
        target = $("." + $(this).data("toggle"))
        if flag == false
            target.show()
            flag = true
        else
            target.hide()
            flag = false

    $("button[data-plus1]").click ->
        target = $(this)
        $.ajax({
            type: "post",
            url: target.data("url"),
            datatype: "json",
            data: {
                "user_skill_id" : target.data("user-skill-id"),
                "plused_user_id" : target.data("plus1")
            },
            success: (data)->
                console.log(target)
                target.text(data.point)
        })
    return
