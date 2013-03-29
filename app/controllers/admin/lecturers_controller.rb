class Admin::LecturersController < Admin::AdminController

  # PUT /admin/lecturers/set_confirmation_level/:lecturer_id/:level
  def set_confirmation_level
      lecturer = Lecturer.find(params[:lecturer_id])
      redirect_to :back and return if lecturer.confirm_level == params[:confirm_level].to_i
      lecturer.update_attributes({:confirm_level => params[:confirm_level]})
      message = PrivateMessage.new({
        :receiver_id => lecturer.user.id, :sender_id => User::SYSTEM_ACCOUNT_ID,
        :title => t("messages.changed_confirm_level_mail_title"),
        :body => t("messages.changed_confirm_level_mail_body",
          :status => confirm_level_text(params[:confirm_level].to_i))
      })
      message.save
      redirect_to :back
  end
  
end