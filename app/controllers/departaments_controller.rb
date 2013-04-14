class DepartamentsController < ApplicationController

  before_filter :require_admin_rights, :only =>
    [:new, :edit, :create, :update, :destroy]

  # GET /departaments
  # Отображает страницу со списком кафедр
  def index
    @departaments = Departament.order('name ASC').all
  end

  # GET /departaments/1
  # Отображат информацию по выбранной кафедре
  def show
    @departament = Departament.find(params[:id])
  end

  # GET /departamnets/new
  # Отображает форму добавления кафедры
  def new
    @departament = Departament.new
  end

  # GET /departaments/1/edit
  # Отображает форму редактирования кафедры
  def edit
    @departament = Departament.find(params[:id])
  end

  # POST /departaments
  # Добавляет информацию о новой кафедре в БД
  def create
    @departament = Departament.new(params[:departament])
    if @departament.save then
      redirect_to :departaments
    else
      render 'new'
    end
  end

  # PUT /departaments/1
  # Обновляет информацию о кафедре
  def update
    @departament = Departament.find(params[:id])
    if @departament.update_attributes(params[:departament]) then
      redirect_to :departaments
    else
      render 'edit'
    end
  end

  # DELETE /departaments/1
  # Удаляет информию о кафедре
  def destroy
    @departament = Departament.find(params[:id])
    @departament.destroy
    redirect_to :departaments
  end

  # GET /departaments/1/lecturers
  # Выводит информацию о преподавателях, работающих на кафедре
  def show_lecturers
    departament = Departament.find(params[:id])
    @lecturers = departament.lecturers
  end

  # GET /departaments/:id/subjects
  # Отображает страницу со списком дисциплин
  def show_subjects
      @departament = Departament.find(params[:id])
      @subjects = @departament.subjects
  end

end