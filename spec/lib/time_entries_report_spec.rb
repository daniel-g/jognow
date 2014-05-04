require 'spec_helper'

describe TimeEntriesReport do
  before do
    create_time_entries
    @time_entry_14_01_2014.update_attributes({
      distance: 5,
      time: 1
    })
    @time_entry_16_01_2014.update_attributes({
      distance: 5,
      time: 1
    })
    @time_entry_14_02_2014.update_attributes({
      distance: 5,
      time: 1
    })
  end

  # it 'looks for time entries after a date' do
  #   @search_params = { from: '16/01/2014' }
  #   @results = TimeEntriesSearch.new(@search_params).results
  #   expect(@results.map(&:date)).to eql [
  #     @time_entry_16_01_2014,
  #     @time_entry_14_02_2014
  #   ].map(&:date)
  # end

  # it 'looks for time entries before a date' do
  #   @search_params = { to: '13/02/2014' }
  #   @results = TimeEntriesSearch.new(@search_params).results
  #   expect(@results.map(&:date)).to eql [
  #     @time_entry_14_01_2014,
  #     @time_entry_16_01_2014
  #   ].map(&:date)
  # end

  it 'looks for time entries between dates' do
    @search_params = {
      from: '14/01/2014', to: '13/02/2014'
    }
    @totals = TimeEntriesReport.new(@search_params).totals
    expect(@totals).to eql({
      distance: 10.0,
      avg_speed: 5.0
    })
  end
end
