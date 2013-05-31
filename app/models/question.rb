class Question < ActiveRecord::Base
  attr_accessible :required, :text, :type

  validates :text, presence: true
end