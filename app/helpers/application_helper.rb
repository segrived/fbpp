module ApplicationHelper
    
  def logged?
    session[:user] != nil && User.find_by_id(session[:user].id) != nil
  end

  def logged_user
    session[:user]
  end

  def exists_admin_account?
    User.exists?(:account_type => User::ACCTYPES[:admin])
  end

  def can_admin?
    logged_user.admin? || logged_user.mod?
  end

  def unread_messages_count
    PrivateMessage.where(:receiver_id => logged_user.id, :read => false).count
  end

def nav_link(link_text, link_path, link_id = nil)
  class_name = current_page?(link_path) ? 'active' : nil
  content_tag(:li) do
    link_to link_text, link_path, :class => class_name, :id => link_id
  end
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
