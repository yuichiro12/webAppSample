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

    $("input.skill-submit").click (e)->
        $(this).prop("disabled", true)
        target = $(this).parent("form")
        t_area = target.children(".skill-name")
        target.prop("disabled", true)
        $.ajax({
            type: "post",
            url: target.attr("action"),
            datatype: "json",
            data: {
                "skill" : {
                    "name" : $.trim(t_area.val())
                },
                "user_skill" : {
                    "user_id" : target.data("userid"),
                    "point" : 0
                }
            },
            success: (data)->
                $("div#skill-list").html(data)
                t_area.val("")
        })
        $(this).prop("disabled", false)
        return e.preventDefault()
        

    $("div#skill-list").on "click", "button[data-plus1]", ->
        target = $(this)
        target.prop("disabled", true)
        $.ajax({
            type: "post",
            url: target.data("url"),
            datatype: "json",
            data: {
                "user_skill_id" : target.data("user-skill-id"),
                "plused_user_id" : target.data("plus1")
            },
            success: (data)->
                target.text(data.point)
        })
        target.prop("disabled", false)
    return
