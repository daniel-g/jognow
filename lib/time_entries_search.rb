class TimeEntriesSearch
  attr_accessor :params

  def initialize(params={})
    @params = params || {}
  end

  def results
    @results = TimeEntry.asc(:date)
    @results = @results.where(:date.gte => params[:from]) if params[:from]
    @results = @results.where(:date.lte => params[:to]) if params[:to]
    @results
  end
end
