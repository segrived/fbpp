jQuery ->
  $('#search_string')
      .focus ->
          @value = "" if @value == I18n.t('layout.search_field')
      .blur ->
          @value = I18n.t('layout.search_field') unless @value