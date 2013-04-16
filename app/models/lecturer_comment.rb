class LecturerComment < ActiveRecord::Base
  belongs_to :comment, :dependent => :destroy
  belongs_to :lecturer
end
