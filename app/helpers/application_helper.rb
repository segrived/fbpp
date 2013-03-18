module ApplicationHelper
    
  def logged?
    session[:user] != nil
  end

  def logged_user
    session[:user]
  end

  def tm(elem)
    t(elem).mb_chars
  end

  def tc(elem)
    tm(elem).capitalize
  end

  def tu(elem)
    tm(elem).upcase
  end

  def td(elem)
    tm(elem).downcase
  end

end
