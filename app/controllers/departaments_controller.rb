class DepartamentsController < ApplicationController
  def list
    @departaments = Departament.all
  end

  def info
    @departament = Departament.find(params[:id])
  end

  def lecturers
    @lecturers = Departament.find(params[:id]).lecturers
  end
end