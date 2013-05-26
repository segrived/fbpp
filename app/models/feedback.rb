class Feedback < ActiveRecord::Base
  belongs_to :student
  belongs_to :subject_subscription
  attr_accessible :time
end