class SpecialtiesController < ApplicationController

  before_filter :require_admin_rights, :except => [:index, :show]

  # GET /specialties
  # Отображает страницу со списком специальностей
  def index
    @specialties = Specialty.order('name ASC').all
  end

  # GET /specialties/:id
  # Отображат информацию по выбранной специальности
  def show
    @specialty = Specialty.find(params[:id])
  end

  # GET /specialties/new
  # Отображает форму добавления специальности
  def new
    @specialty = Specialty.new
  end

  # GET /specialties/:id/edit
  # Отображает форму редактирования специальности
  def edit
    @specialty = Specialty.find(params[:id])
  end

  # POST /specialties
  # Добавляет информацию о новой специальности в БД
  def create
    @specialty = Specialty.new(params[:specialty])
    if @specialty.save then
      redirect_to :specialties and return
    else
      render 'new'
    end
  end

  # PUT /specialties/:id
  # Обновляет информацию о специальности
  def update
    @specialty = Departament.find(params[:id])
    if @specialty.update_attributes(params[:specialty]) then
      redirect_to :specialties and return
    else
      render 'edit'
    end
  end

  # DELETE /specialties/:id
  # Удаляет информию о специальности
  def destroy
    @specialty = Departament.find(params[:id])
    @specialty.destroy
    redirect_to :specialties
  end

end