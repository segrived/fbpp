jQuery ->
  if not Array.prototype.some
      Array.prototype.some = (f) -> (x for x in @ when f(x)).length > 0

  if not Array.prototype.every
      Array.prototype.every = (f) -> (x for x in @ when f(x)).length == @length

    $(".show-connected-feedback").click ->
      feedback = $(@).closest('.comment').find('.connected-feedback')
      feedback.toggle 200, () ->
        $.scrollTo $(feedback)