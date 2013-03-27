jQuery ->
  $('#unread-messages-count').visible = 
  $('#search_string')
    .focus ->
      @value = "" if @value == I18n.t('layout.search_field')
    .blur ->
      @value = I18n.t('layout.search_field') unless @value

  setIntervalAndExecute= (fn, t) ->
    do fn
    setInterval fn, t

  show_new_messages= ->
    $.get '/unread_messages_count', (data) ->
      count = data.count
      if count == 0
        $('#unread-messages-count').hide()
      else
        $('#unread-messages-count').show()
        $('#unread-messages-count').text('(' + data.count + ')')

  setIntervalAndExecute(show_new_messages, 10000)