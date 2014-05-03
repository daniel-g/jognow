require 'spec_helper'

describe TimeEntry do
  it 'validates the distance is a float number greater than zero' do
    @time_entry = build(:time_entry, distance: -1.5)
    expect(@time_entry).to_not be_valid
    @time_entry.distance = 0
    expect(@time_entry).to_not be_valid
    @time_entry.distance = 1.5
    expect(@time_entry).to be_valid
  end

  it 'validates the time is a float number greater than zero' do
    @time_entry = build(:time_entry, time: -1.5)
    expect(@time_entry).to_not be_valid
    @time_entry.time = 0
    expect(@time_entry).to_not be_valid
    @time_entry.time = 1.5
    expect(@time_entry).to be_valid
  end

  it 'calculates the average speed' do
    @time_entry = TimeEntry.create(distance: 1000, time: 100)
    expect(@time_entry.avg_speed).to eql 10.0
  end
end
