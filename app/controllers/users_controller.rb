class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if ! @user.save then
      render 'new'
      false
    end

    # В случае регистрации студента
    if @user.student? then
      @s = Student.new(
        :user_id => @user.id,
        :course => params[:course],
        :specialty_id => params[:specialty])
      @s.save!
    # В случае регистрации преподавателя
    elsif @user.lecturer? then
      @l = Lecturer.new(
        :user_id => @user.id,
        :degree => params[:degree],
        :departament_id => params[:departament])
      @l.save!
    end
    
  end
end