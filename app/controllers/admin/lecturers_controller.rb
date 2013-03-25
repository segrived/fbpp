class Admin::LecturersController < Admin::AdminController

  # PUT /admin/lecturers/set_confirmation_level/:lecturer_id/:level
  def set_confirmation_level
      lecturer = Lecturer.find(params[:lecturer_id])
      lecturer.update_attributes({:confirm_level => params[:confirm_level]})
      redirect_to :back
  end
  
end