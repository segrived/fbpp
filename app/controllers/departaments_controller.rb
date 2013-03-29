class DepartamentsController < ApplicationController

  before_filter :require_admin_rights, :except => [:index, :show, :show_lecturers]

  # GET /departaments
  # Отображает страницу со списком кафедр
  def index
    @departaments = Departament.order('name ASC').all
  end

  # GET /departaments/1
  # Отображат информацию по выбранной кафедре
  def show
    begin
      @departament = Departament.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :departaments
    end
  end

  # GET /departamnets/new
  # Отображает форму добавления кафедры
  def new
    @departament = Departament.new
  end

  # GET /departaments/1/edit
  # Отображает форму редактирования кафедры
  def edit
    begin
      @departament = Departament.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :departaments
    end
  end

  # POST /departaments
  # Добавляет информацию о новой кафедре в БД
  def create
    @departament = Departament.new(params[:departament])
    if @departament.save then
      redirect_to :departaments and return
    else
      render 'new'
    end
  end

  # PUT /departaments/1
  # Обновляет информацию о кафедре
  def update
    begin
      @departament = Departament.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :departaments and return
    end
    if @departament.update_attributes(params[:departament]) then
      redirect_to :departaments and return
    else
      render 'edit'
    end
  end

  # DELETE /departaments/1
  # Удаляет информию о кафедре
  def destroy
    begin
      @departament = Departament.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :departaments and return
    end
    @departament.destroy
    redirect_to :departaments
  end

  # GET /departaments/1/lecturers
  # Выводит информацию о преподавателях, работающих на кафедре
  def show_lecturers
    begin
      departament = Departament.find(params[:id])
      @lecturers = departament.lecturers
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :departaments
    end
  end

end