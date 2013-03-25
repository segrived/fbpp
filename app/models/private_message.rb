class PrivateMessage < ActiveRecord::Base
  belongs_to :sender
  belongs_to :receiver
  attr_accessible :body, :read, :sendtime, :title
end
