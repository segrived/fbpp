class QuestionsController < ApplicationController

  before_filter :require_admin_rights

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    if @question.save then
      redirect_to :questions
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question]) then
      redirect_to :questions and return
    else
      render :edit
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to :questions
  end

end