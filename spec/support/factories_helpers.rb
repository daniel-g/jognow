module FactoriesHelpers
  def build_time_entries(user)
    _time_entries(:build, user)
  end

  def create_time_entries(user)
    _time_entries(:create, user)
  end

  def _time_entries(method, user)
    @time_entry_14_02_2014 = send(method, :time_entry, date: Date.new(2014, 2, 14), user: user)
    @time_entry_16_01_2014 = send(method, :time_entry, date: Date.new(2014, 1, 16), user: user)
    @time_entry_14_01_2014 = send(method, :time_entry, date: Date.new(2014, 1, 14), user: user)
  end
end
