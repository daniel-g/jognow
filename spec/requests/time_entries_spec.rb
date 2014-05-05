require 'spec_helper'

describe '/time_entries/', '#POST' do
  let!(:user){ create(:user) }
  before do
    login_as user
  end

  it 'creates a time entry' do
    expect{
      post time_entries_path(format: :json), time_entry: {
        date: '02/03/2014',
        distance: '1000',
        time: (60*20).to_s
      }
    }.to change{ TimeEntry.count }.from(0).to(1)
    @time_entry = TimeEntry.first
    expect(@time_entry.date).to eql(Date.new(2014, 3, 2))
    expect(@time_entry.distance).to eql(1000.0)
    expect(@time_entry.time).to eql(60*20.0)
    expect(@time_entry.avg_speed).to eql(1000.to_f/(60*20))
    expect(@time_entry.user).to eql(user)
  end

  it 'returns errors if the time entry cannot be created' do
    post time_entries_path(format: :json), time_entry: {
      date: '02/03/2014',
      distance: '-1',
      time: -60*20
    }
    @errors = JSON.parse(response.body)
    expect(@errors).to eql({
      'errors' => {"distance"=>["must be greater than 0"], "time"=>["must be greater than 0"]}
    })
  end
end

describe '/time_entries', '#GET' do
  let!(:user){ create(:user) }

  before do
    create_time_entries(user)
    login_as user
  end

  it 'looks for time entries of the current user registered from a date' do
    @extra_time_entry = create(:time_entry, date: Date.new(2014, 2, 14), user: create(:user, email: 'another@doe.com'))
    get time_entries_path, { format: :json,
      from: '16/01/2014'
    }
    expect(JSON.parse(response.body)).to eql(
      JSON.parse([@time_entry_16_01_2014, @time_entry_14_02_2014].to_json)
    )
  end

  it 'looks for the time entries of the current user registered to a date' do
    @extra_time_entry = create(:time_entry, date: Date.new(2014, 1, 10), user: create(:user, email: 'another@doe.com'))
    get time_entries_path, { format: :json,
      to: '14/01/2014'
    }
    expect(JSON.parse(response.body)).to eql(
      JSON.parse([@time_entry_14_01_2014].to_json)
    )
  end

  it 'looks for time entries of the current user registered from - to a date' do
    @extra_time_entry = create(:time_entry, date: Date.new(2014, 1, 20), user: create(:user, email: 'another@doe.com'))
    get time_entries_path, { format: :json,
      from: '16/01/2014', to: '14/02/2014'
    }
    expect(JSON.parse(response.body)).to eql(
      JSON.parse([@time_entry_16_01_2014, @time_entry_14_02_2014].to_json)
    )
  end
end
