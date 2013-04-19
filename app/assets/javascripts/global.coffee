jQuery ->

  setIntervalAndExecute = (fn, t) ->
    do fn
    setInterval fn, t

  show_new_messages = ->
    $.get '/ajax/unread_messages_count', (data) ->
      count = data.count
      if count == 0
        $('#unread-messages-count').hide()
      else
        $('#unread-messages-count').show().text('(' + data.count + ')')

  setIntervalAndExecute(show_new_messages, 10000)

  $("#show-comment-form").click ->
    $(@).hide()
    $("#add-comment-form").show()
    $('body').scrollTo('#add-comment-form', 300)
  $("#cancel-add-comment").click ->
    $("#add-comment-form").hide()
    $("#show-comment-form").show()

  $(".show-comment-button").click ->
    $(@).parent().next('.comment').removeClass('hidden')
    $(@).parent('.hidden-comment-message').hide()