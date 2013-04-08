class SubjectsController < ApplicationController

  # before_filter :require_admin_rights

  # GET /subjects
  # Отображает страницу со списком дисциплин
  def index
    @subjects = Subject.order('name ASC').all
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # POST /subjects
  def create
    @subject = Subject.new(params[:subject])
    unless @subject.save then
      render 'new'
    end
  end

  # GET /subjects/:id/edit
  def edit
    @subject = Subject.find(params[:id])
  end

  # PUT /subjects/:id
  def update
    begin
      @subject = Subject.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :subject and return
    end
    if @subject.update_attributes(params[:subject]) then
      redirect_to :subject and return
    else
      render 'edit'
    end
  end

  # GET /subjects/:id
  def show
    @subject = Subject.find(params[:id])
  end

end