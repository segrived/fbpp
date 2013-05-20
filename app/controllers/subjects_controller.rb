class SubjectsController < ApplicationController

  before_filter :require_admin_rights, :except => [:index, :show, :subscribe, :unsubscribe]

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
    if @subject.save then
      redirect_to :subjects and return
    else
      render 'new'
    end
  end

  # GET /subjects/:id/edit
  def edit
    @subject = Subject.find(params[:id])
  end

  # PUT /subjects/:id
  def update
    @subject = Subject.find(params[:id])
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

  # POST /subjects/subscribe/:id
  def subscribe
    unless logged_user.lecturer? then
        redirect_to :root and return
    end
    @subs = SubjectSubscription.new(
      lecturer_id: logged_user.lecturer.id,
      subject_id: params[:id])
    @subs.save
    redirect_to :back
  end

  def unsubscribe
    unless logged_user.lecturer? then
        redirect_to :root and return
    end
    @subs = SubjectSubscription.destroy_all(
      lecturer_id: logged_user.lecturer.id,
      subject_id: params[:id])
    redirect_to :back
  end

end