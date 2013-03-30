class LecturerComment < ActiveRecord::Base
  belongs_to :comment
  belongs_to :lecturer
end
