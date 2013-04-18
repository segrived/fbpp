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

  # Возвращает логин пользователя по ID
  def user_login(id, add_link = true)
    return t("common.system_account_name") if id == User::SYSTEM_ACCOUNT_ID
    user = User.where(id: id)
    return t("common.unknown_account_name") if user.count == 0
    if add_link
      return link_to user.first.login, profile_path(user.first.login)
    else
      return user.first.login
    end
  end

  # Возвращает количество непрочитанных сообщений для текущего пользователя
  def unread_messages
    return nil unless logged?
    logged_user.received_messages.where(read: false).count
  end

  def nav_link(link_text, link_path, link_id = nil)
    class_name = current_page?(link_path) ? 'active' : nil
    link_to link_text, link_path, :class => class_name, :id => link_id
  end

  def comment_class_by_mark(mark)
    case mark
      when Comment::MARKS[:good] then 'positive'
      when Comment::MARKS[:bad] then 'negative'
      when Comment::MARKS[:neutral] then 'neutral'
    end
  end

  def vote_class_by_rating(vote)
    case
      when vote < 0 then 'downvoted'
      when vote == 0 then 'normal'
      when vote > 0 then 'upvoted'
    end
  end

  def confirm_level_text(sym)
    t("confirm_levels.#{Lecturer::CONFIRM_LEVELS.key(sym).to_s}")
  end

  def tm(elem)
    t(elem).mb_chars
  end

  def tc(elem)
    tm(elem).capitalize
  end

end
