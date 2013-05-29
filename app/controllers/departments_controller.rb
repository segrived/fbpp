class DepartmentsController < ApplicationController

  before_filter :require_admin_rights, :only =>
    [ :new, :edit, :create, :update, :destroy ]

  # GET /departments
  # Отображает страницу со списком кафедр
  def index
    @departments = Department.order('name ASC').all
  end

  # GET /departments/:id
  # Отображат информацию по выбранной кафедре
  def show
    @department = Department.find(params[:id])
  end

  # GET /departments/new
  # Отображает форму добавления кафедры
  def new
    @department = Department.new
  end

  # GET /departments/:id/edit
  # Отображает форму редактирования кафедры
  def edit
    @department = Department.find(params[:id])
  end

  # POST /departments
  # Добавляет информацию о новой кафедре в БД
  def create
    @department = Department.new(params[:department])
    if @department.save then
      redirect_to :departments
    else
      render 'new'
    end
  end

  # PUT /departments/:id
  # Обновляет информацию о кафедре
  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(params[:department]) then
      redirect_to :departments
    else
      render 'edit'
    end
  end

  # DELETE /departments/:id
  # Удаляет информию о кафедре
  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to :departments
  end

  # GET /departments/:id/lecturers
  # Выводит информацию о преподавателях, работающих на кафедре
  def lecturers
    @lecturers = Department.find(params[:id]).lecturers
  end

  # GET /departments/:id/subjects
  # Отображает страницу со списком дисциплин
  def subjects
    @subjects = Department.find(params[:id]).subjects
  end

end