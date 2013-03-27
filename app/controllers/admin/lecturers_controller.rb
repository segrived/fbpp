class Admin::LecturersController < Admin::AdminController

  # PUT /admin/lecturers/set_confirmation_level/:lecturer_id/:level
  def set_confirmation_level
      lecturer = Lecturer.find(params[:lecturer_id])
      lecturer.update_attributes({:confirm_level => params[:confirm_level]})
      message = PrivateMessage.new({
        :receiver_id => lecturer.user.id, :sender_id => logged_user.id,
        :title => "Статус аккаунта был изменен",
        :body => "Статут вашего аккаунта был изменен"
      })
      message.save
      redirect_to :back
  end
  
end