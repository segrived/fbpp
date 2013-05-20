class ApiKey < ActiveRecord::Base
  belongs_to :user
  attr_accessible :expiry_date, :key, :user_id
end
