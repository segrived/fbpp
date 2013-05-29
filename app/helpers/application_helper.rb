module ApplicationHelper

  # Возвращает статус авторизации пользователя
  # * *Returns* :
  # Булевое значение, определяющее, авторизирован пользователь или нет
  def logged?
    (session[:user_id] != nil) && (User.where(id: session[:user_id]).count > 0)
  end

  # Возвращает объект текущего авторизированного пользователя. Рекомендуется использовать
  # в связке с функцией logged?, так как данная функция, в случае, если пользователь
  # не найден, выбрасывает исключение
  # * *Returns* :
  # Объект, представляющий авторизированного пользователя
  def logged_user
    User.find(session[:user_id])
  end

  def clear_user_session
    session[:user_id] = nil
  end

  # Проверяет наличие аккаунта администратора в системе
  # * *Returns* :
  # Булевое значение, определяющее, создан ли уже аккаунт администратора или нет
  def exists_admin_account?
    User.exists?(account_type: User::ACCTYPES[:admin])
  end

  # Проверяет аккаунт авторизированного пользователя на наличие администраторских полномочий
  # * *Returns* :
  # Булевое значение, определяющее, может ли авторизированный пользователь администрировать систему
  def can_admin?
    logged? && (logged_user.admin? || logged_user.mod?)
  end

  def nav_link(link_text, link_path, link_id = nil)
    class_name = current_page?(link_path) ? 'active' : nil
    link_to link_text, link_path, :class => class_name, :id => link_id
  end

  def block_title(title, icon = nil)
    title = image_tag(icon, class: 'block-title-icon') + title if icon
    content_tag(:div, title.html_safe, class: 'block-title')
  end

  def block_tabs(tabs)
    tabs_html = ""
    tabs.each do |tab|
      link = nav_link tab.first, tab.last
      tabs_html << content_tag(:span, link, class: 'block-tabs-tab')
    end
    content_tag(:div, tabs_html.html_safe, class: 'block-tabs')
  end

  def has_sidebar?
    @has_sidebar.nil? ? true : @has_sidebar
  end

  def content_start(&block)
    tag_class = 'full' unless has_sidebar?
    content_tag(:div, capture(&block), id: 'content', class: tag_class || nil)
  end

  def messages
    render(:template =>"shared/_messages.html.haml", :layout => nil)
  end

  def btn_link(body, url, comp = false, color = nil, html_options = {})
    html_options[:class] = 'button'
    html_options[:class] << ' compact' if comp
    html_options[:class] << " btn-#{color}" if color
    link_to(body, url, html_options)
  end

  def get_comment_class_by_mark(mark)
    Comment::MARKS.key(mark).to_s
  end

end