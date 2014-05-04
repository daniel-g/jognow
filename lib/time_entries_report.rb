class TimeEntriesReport
  attr_accessor :params

  def initialize(params={})
    @params = params || {}
  end

  def results
    @results ||= TimeEntriesSearch.new(params).results
  end

  def totals
    @totals ||= {
      distance: results.sum(:distance),
      avg_speed: results.avg(:avg_speed)
    }
  end
end
