class Subject < ActiveRecord::Base
  belongs_to :department
  has_many :subject_subscriptions
  attr_accessible :department_id, :description, :name

  validates :name, presence: true, uniqueness: true
  validates :department, existence: true
end