class Feedback < ActiveRecord::Base
  belongs_to :student
  belongs_to :subject_subscription

  has_many :feedback_answers, dependent: :destroy

  has_one :feedback_comment, dependent: :destroy

  attr_accessible :time, :student_id, :subject_subscription_id

  validates :student, :subject_subscription, existence: true
end