jQuery ->
  $('#search_string')
      .focus ->
          @value = ""
      .blur ->
          @value = I18n.t('layout.searchField')