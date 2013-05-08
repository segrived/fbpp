class SettingsController < ApplicationController

  before_filter :require_auth

  # PUT /settings/change_password
  def change_password
    @user = logged_user
    # Пришёл запрос на обновление пароля
    if request.put? then
      current_password = params[:current_password]
      unless User.authenticate(@user.login, current_password) then
        @user.errors[:base] << t('settings.invalid_current_password')
        render :change_password and return
      end
      # Обновляемые атрибуты
      attributes = { password: params[:user][:password],
        password_confirmation: params[:user][:password_confirmation] }
      # В случае успешного обновления пароля
      if @user.update_attributes(attributes) then
        redirect_to :settings_change_password,
          alert: t('settings.password_has_been_changed')
      else
        render :change_password
      end
    end
  end

  # GET /settings/remove_account
  # DELETE /settings/remove_account
  def remove_account
    if request.get? then
      render :remove_account and return
    end

    if request.delete? then
      if logged_user.admin? then
        redirect_to :settings_remove_account, notice: 'cant-delete' and return
      end
      logged_user.update_attributes({ removed: true, account_type: nil })
      # Выход из системы
      clear_user_session
      redirect_to :login, :alert => "Аккаунт был успешно удалён"
    end
  end

  # GET /settings/lecturer
  # PUT /settings/lecturer
  def lecturer
    unless logged_user.lecturer? then
      render_403 and return
    end
    if request.get? then
      @lecturer = logged_user.lecturer
    elsif request.put? then
      lecturer = Lecturer.find(logged_user.lecturer.id)
      lecturer.departament_id = params[:departament]
      lecturer.scientific_degree_id = params[:degree]
      # Сброс уровная подтверждения преподавателя
      unless lecturer.real? then
        lecturer.confirm_level = Lecturer::CONFIRM_LEVELS[:unconfirmed]
      end
      if lecturer.save then
        redirect_to :settings_lecturer, alert: t('settings.save_suc')
      else
        redirect_to :settings_lecturer, notice: t('settings.save_fail')
      end
    end
  end

  # GET /settings/student
  # PUT /settings/student
  def student
    unless logged_user.student? then
      render_403 and return
    end
    if request.get? then
      @student = logged_user.student
    elsif request.put? then
      student = Student.find(logged_user.student.id)
      student.specialty_id = params[:specialty]
      student.course = params[:course]
      if student.save then
        redirect_to :settings_student, alert: t('settings.save_suc')
      else
        redirect_to :settings_student, alert: t('settings.save_fail')
      end
    end
  end

  def personal
    if request.put? then
      logged_user.update_attributes({
        name: params[:name],
        surname: params[:surname],
        patronymic: params[:patronymic]})
      redirect_to :back, alert: "Изменения были успешно сохранены"
    end
  end

end