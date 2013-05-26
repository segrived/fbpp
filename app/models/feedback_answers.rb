class FeedbackAnswers < ActiveRecord::Base
  attr_accessible :answer, :feedback, :question
end
