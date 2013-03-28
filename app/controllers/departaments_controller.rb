class DepartamentsController < ApplicationController
  # GET /departaments
  def index
    @departaments = Departament.order('name ASC').all
  end

  # GET /departaments/1
  def show
    @departament = Departament.find_by_id(params[:id])
    redirect_to :departaments and return unless @departament
  end

  # GET /departamnets/new
  def new
    @departament = Departament.new
  end

  # GET /departaments/1/edit
  def edit
    @departament = Departament.find(params[:id])
  end

  # POST /departaments
  def create
    @departament = Departament.new(params[:departament])
    redirect_to :departaments and return if @departament.save
    render 'new'
  end

  # PUT /departaments/1
  def update
    @departament = Departament.find(params[:id])
    if @departament.update_attributes(params[:departament]) then
      redirect_to :departaments
    end
  end

  # DELETE /departaments/1
  def destroy
    @departament = Departament.find(params[:id])
    @departament.destroy
    redirect_to :departaments
  end

  # GET /departaments/1/lecturers
  def show_lecturers
    @lecturers = Departament.find(params[:id]).lecturers
  end

end