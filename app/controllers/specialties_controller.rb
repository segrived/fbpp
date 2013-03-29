class SpecialtiesController < ApplicationController

  before_filter :require_admin_rights, :except => [:index, :show]

  # GET /specialties
  # Отображает страницу со списком специальностей
  def index
    @specialties = Specialty.order('name ASC').all
  end

  # GET /specialties/1
  # Отображат информацию по выбранной специальности
  def show
    begin
      @specialty = Specialty.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :specialties
    end
  end

  # GET /specialties/new
  # Отображает форму добавления специальности
  def new
    @specialty = Specialty.new
  end

  # GET /specialties/1/edit
  # Отображает форму редактирования специальности
  def edit
    begin
      @specialty = Specialty.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :specialties
    end
  end

  # POST /specialties
  # Добавляет информацию о новой специальности в БД
  def create
    @specialty = Specialty.new(params[:specialty])
    if @specialty.save
      redirect_to :specialties and return
    else
      render 'new'
    end
  end

  # PUT /specialties/1
  # Обновляет информацию о специальности
  def update
    begin
      @specialty = Departament.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :specialties and return
    end
    if @specialty.update_attributes(params[:specialty]) then
      redirect_to :specialties and return
    else
      render 'edit'
    end
  end

  # DELETE /specialties/1
  # Удаляет информию о специальности
  def destroy
    begin
      @specialty = Departament.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :specialties and return
    end
    @specialty.destroy
    redirect_to :specialties
  end

end