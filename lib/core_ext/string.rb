class String
  def cap_first
    self.slice(0,1).mb_chars.capitalize + self.slice(1..-1)
  end

  def mb_upcase
    self.mb_chars.upcase
  end

  def mb_downcase
    self.mb_chars.downcase
  end
end

class ActionView::Helpers::FormBuilder
  def select(text, options = {})
    @template.content_tag(:select, text, options)
  end
end