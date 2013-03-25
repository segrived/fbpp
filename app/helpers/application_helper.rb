module ApplicationHelper
    
  def logged?
    session[:user] != nil && User.find_by_id(session[:user].id) != nil
  end

  def logged_user
    session[:user]
  end

  def can_admin?
    logged_user.admin? || logged_user.mod?
  end

  def unread_messages_count
    PrivateMessage.where(:receiver_id => logged_user.id, :read => false).count
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
