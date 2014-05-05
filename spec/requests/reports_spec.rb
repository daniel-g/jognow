require 'spec_helper'

describe '/reports' do
  describe '/time_entries', '#GET' do
    let!(:user){ create(:user) }

    before do
      create_time_entries(user)
      @time_entry_16_01_2014.update_attributes({
        distance: 5,
        time: 1
      })
      @time_entry_14_02_2014.update_attributes({
        distance: 5,
        time: 1
      })
      login_as user
    end

    it 'reports time entries\'s big numbers from - to a date' do
      get time_entries_reports_path, { format: :json,
        from: '16/01/2014', to: '14/02/2014'
      }
      expect(JSON.parse(response.body)).to eql({
        'distance' => 10.0,
        'avg_speed' => 5.0
      })
    end
  end
end
