jQuery ->
  
  $('#search_string')
    .focus ->
      @value = "" if @value == I18n.t('layout.search_field')
    .blur ->
      @value = I18n.t('layout.search_field') unless @value

  setIntervalAndExecute= (fn, t) ->
    do fn
    setInterval fn, t

  show_new_messages= ->
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