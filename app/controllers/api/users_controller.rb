class Api::UsersController < Api::ApiController

  def get_all
      render :json => User.limit(1000)
  end

  # Получает информацию о пользователе по ID
  # GET /api/users/get_user_by_id
  # Формат ответа:
  # - User information
  def get_user_by_id
    if user = User.find_by_id(params[:id]) then
      render :json => user
    else
      render_error t('api_messages.user_not_found')
    end
  end

  # Получает всю информацию о преподавателе, включая информацию о
  # кафедре и научной степени преподавателя
  # GET /api/users/get_lecturer_by_id/:id
  # Формат ответа:
  # - Lecturer information
  # |- user - общая информация о пользователе
  # |- departament - информация о кафедре, на которой работает преподаватель
  # |- scientific_degree - ученая степень преподавателя
  def get_lecturer_by_id
    if lecturer = Lecturer.find_by_id(params[:id]) then
      render :json => lecturer, :include => [ :user, :departament, :scientific_degree ]
    else
      render_error t('api_messages.user_not_found')
    end
  end

end