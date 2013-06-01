class HomeController < ApplicationController

  def index
    @news = NewsItem.order('posttime DESC').limit(10)
  end

  def statistic
    _feedbacks_leaders = Lecturer.feedback_leaders(10)
    @feedbacks_leaders = Lecturer
      .where(id: _feedbacks_leaders.keys)
      .map { |l| [l, _feedbacks_leaders[l.id.to_s]] }
      .sort_by {|k, v| v}.reverse.inject({}) do |r, s|
        r.merge!({s[0] => s[1]})
      end
    _comment_leaders = Lecturer.comment_leaders(10)
    @comment_leaders = Lecturer
      .where(id: _comment_leaders.keys)
      .map { |l| [l, _comment_leaders[l.id.to_s]] }
      .sort_by {|k, v| v}.reverse.inject({}) do |r, s|
        r.merge!({s[0] => s[1]})
      end
  end

end
