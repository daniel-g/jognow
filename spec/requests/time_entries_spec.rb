require 'spec_helper'

describe '/time_entries/:id' do
  it 'creates a time entry' do
    expect{
      post time_entries_path, time_entry: {
        date: '02/03/2014',
        distance: '1000',
        time: (60*20).to_s
      }
    }.to change{ TimeEntry.count }.from(0).to(1)
    @time_entry = TimeEntry.first
    expect(@time_entry.date).to eql(Date.new(2014, 3, 2))
    expect(@time_entry.distance).to eql(1000)
    expect(@time_entry.time).to eql(60*20)
    expect(@time_entry.avg_speed).to eql(1000.to_f/(60*20))
  end
end
