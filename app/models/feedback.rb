class Feedback < ActiveRecord::Base
  belongs_to :student
  belongs_to :subject_subscription
  has_many :feedback_answers, dependent: :destroy
  attr_accessible :time, :student_id, :subject_subscription_id
end