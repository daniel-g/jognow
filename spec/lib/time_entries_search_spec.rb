require 'spec_helper'

describe TimeEntriesSearch do
  before do
    create_time_entries
  end

  it 'looks for all time entries ordered by date' do
    @results = TimeEntriesSearch.new(@search_params).results
    expect(@results.map(&:date)).to eql [
      @time_entry_14_01_2014,
      @time_entry_16_01_2014,
      @time_entry_14_02_2014
    ].map(&:date)
  end

  it 'looks for time entries after a date' do
    @search_params = { from: '16/01/2014' }
    @results = TimeEntriesSearch.new(@search_params).results
    expect(@results.map(&:date)).to eql [
      @time_entry_16_01_2014,
      @time_entry_14_02_2014
    ].map(&:date)
  end

  it 'looks for time entries before a date' do
    @search_params = { to: '13/02/2014' }
    @results = TimeEntriesSearch.new(@search_params).results
    expect(@results.map(&:date)).to eql [
      @time_entry_14_01_2014,
      @time_entry_16_01_2014
    ].map(&:date)
  end

  it 'looks for time entries between dates' do
    @search_params = {
     from: '15/01/2014', to: '13/02/2014'
    }
    @results = TimeEntriesSearch.new(@search_params).results
    expect(@results.to_a).to eql [
      @time_entry_16_01_2014
    ]
  end
end
