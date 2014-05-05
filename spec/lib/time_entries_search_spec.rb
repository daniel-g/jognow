require 'spec_helper'

describe TimeEntriesSearch, 'results' do
  before do
    @user = create(:user)
    create_time_entries(@user)
  end

  it 'looks for all time entries ordered by date' do
    @results = TimeEntriesSearch.new(@user, @search_params).results
    expect(@results.map(&:date)).to eql [
      @time_entry_14_01_2014,
      @time_entry_16_01_2014,
      @time_entry_14_02_2014
    ].map(&:date)
  end

  it 'looks for time entries after a date' do
    @search_params = { from: '16/01/2014' }
    @results = TimeEntriesSearch.new(@user, @search_params).results
    expect(@results.map(&:date)).to eql [
      @time_entry_16_01_2014,
      @time_entry_14_02_2014
    ].map(&:date)
  end

  it 'looks for time entries before a date' do
    @search_params = { to: '13/02/2014' }
    @results = TimeEntriesSearch.new(@user, @search_params).results
    expect(@results.map(&:date)).to eql [
      @time_entry_14_01_2014,
      @time_entry_16_01_2014
    ].map(&:date)
  end

  it 'looks for time entries between dates' do
    @search_params = {
     from: '15/01/2014', to: '13/02/2014'
    }
    @results = TimeEntriesSearch.new(@user, @search_params).results
    expect(@results.to_a).to eql [
      @time_entry_16_01_2014
    ]
  end
end

describe TimeEntriesSearch, 'totals' do
  before do
    @user = create(:user)
    create_time_entries(@user)
    @time_entry_14_01_2014.update_attributes({
      distance: 5,
      time: 1
    })
    @time_entry_16_01_2014.update_attributes({
      distance: 10,
      time: 1
    })
    @time_entry_14_02_2014.update_attributes({
      distance: 15,
      time: 1
    })
  end

  it 'looks for time entries after a date' do
    @search_params = { from: '16/01/2014' }
    @totals = TimeEntriesSearch.new(@user, @search_params).totals
    expect(@totals).to eql({
      distance: 25.0,
      avg_speed: 25.0/2
    })
  end

  it 'looks for time entries before a date' do
    @search_params = { to: '13/02/2014' }
    @totals = TimeEntriesSearch.new(@user, @search_params).totals
    expect(@totals).to eql({
      distance: 15.0,
      avg_speed: 15.0/2
    })
  end

  it 'looks for time entries between dates' do
    @search_params = {
      from: '14/01/2014', to: '13/02/2014'
    }
    @totals = TimeEntriesSearch.new(@user, @search_params).totals
    expect(@totals).to eql({
      distance: 15.0,
      avg_speed: 15/2.0
    })
  end
end
