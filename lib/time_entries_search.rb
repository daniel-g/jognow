class TimeEntriesSearch
  attr_accessor :params, :user

  def initialize(user, params={})
    @params = params || {}
    @user = user
  end

  def results
    return @results if defined? @results
    @results = user.time_entries.asc(:date)
    @results = @results.where(:date.gte => params[:from].to_date) if params[:from]
    @results = @results.where(:date.lte => params[:to].to_date) if params[:to]
    @results
  end

  def totals
    @totals ||= {
      distance: results.sum(:distance),
      avg_speed: results.avg(:avg_speed)
    }
  end
end
