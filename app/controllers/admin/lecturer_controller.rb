class Admin::LecturersController < Admin::AdminController
    # PUT /admin/lecturers/set_confirmation_level/:lecturer_id/:level
    def set_confirmation_level
        lecturer = Lecurer.find(params[:user_id])
        lecturer.confirm_level = params[:level]
        lecturer.save
    end
end