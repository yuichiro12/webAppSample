# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    # テキストエリアのtoggle表示
    do ->
        flag = false
        $(".remove-skill").hide()
        $("button.toggle-edit-button").click ->
            target1 = $(".form-add-skill")
            target2 = $(".remove-skill")
            if flag == false
                target1.show()
                target2.show()
                flag = true
            else
                target1.hide()
                target2.hide()
                flag = false


    # autocomplete
    do ->
        skill_list = $("input#skill-list").val().split(",")
        $("input.skill-name").autocomplete({
            source: skill_list,
            autoFocus: true
        })

    # スキルの追加
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
        

    # +1する/取り消す
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
            # TODO エラー時の処理
            success: (data)->
                target.text(data.point)
        })
        target.prop("disabled", false)


    # スキルの削除
    $("div#skill-list").on "click", "span.remove-skill", ->
        target = $(this)
        target.prop("disabled", true)
        $.ajax({
            type: "post",
            url: target.data("url"),
            data: {
                "user_id" : target.data("user-id"),
                "user_skill_id" : target.data("user-skill-id")
            },
            # TODO エラー時の処理
            success: (data)->
                $("div#skill-list").html(data)
        })
        target.prop("disabled", false)
