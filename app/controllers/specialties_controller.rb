class SpecialtiesController < ApplicationController

  before_filter :require_admin_rights,
    :only => [:new, :edit, :create, :update, :destroy]

  # GET /specialties
  def index
    @specialties = Specialty.order('name ASC').all
  end

  # GET /specialties/1
  def show
    @specialty = Specialty.find_by_id(params[:id])
    redirect_to :specialties and return unless @specialty
  end

  # GET /specialties/new
  def new
    @specialty = Specialty.new
  end

  # GET /specialties/1/edit
  def edit
    @specialty = Specialty.find(params[:id])
  end

  # POST /specialties
  def create
    @specialty = Specialty.new(params[:specialty])
    redirect_to :specialties and return if @specialty.save
    render 'new'
  end

  # PUT /specialties/1
  def update
    @specialty = Specialty.find(params[:id])
    if @specialty.update_attributes(params[:specialty]) then
      redirect_to :specialties
    end
  end

  # DELETE /specialties/1
  def destroy
    @specialty = Specialty.find(params[:id])
    @specialty.destroy
    redirect_to :specialties
  end

end