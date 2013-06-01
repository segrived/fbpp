class NewsItem < ActiveRecord::Base
  belongs_to :user
  attr_accessible :posttime, :text, :user_id
  validates :text, presence: true

  before_create :set_posttime

  def set_posttime
    self.posttime = Time.now
  end
end
