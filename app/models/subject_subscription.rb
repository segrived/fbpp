class SubjectSubscription < ActiveRecord::Base
  belongs_to :subject
  belongs_to :lecturer
  attr_accessible :subject_id, :lecturer_id

  validates :subject_id, :lecturer_id, presence: true
  validates :subject_id, :uniqueness => { :scope => :lecturer_id }
end
