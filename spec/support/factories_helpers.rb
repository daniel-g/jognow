module FactoriesHelpers
  def build_time_entries
    _time_entries(:build)
  end

  def create_time_entries
    _time_entries(:create)
  end

  def _time_entries(method)
    @time_entry_14_02_2014 = send(method, :time_entry, date: Date.new(2014, 2, 14))
    @time_entry_16_01_2014 = send(method, :time_entry, date: Date.new(2014, 1, 16))
    @time_entry_14_01_2014 = send(method, :time_entry, date: Date.new(2014, 1, 14))
  end
end
