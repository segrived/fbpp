class WelcomeController < ApplicationController
  def index
  end

  def faq
  end

  def about
  end

  def departaments
    @departaments = Departament.all
  end

  def departament
    @departament = Departament.find(params[:id])
  end

  def departament_lecturers
    @lecturers = Departament.find(params[:id]).lecturers
  end
end
