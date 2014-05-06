require 'spec_helper'

feature 'Track jog time' do
  let!(:user){ create(:user) }

  before do
    login_as user
  end

  scenario 'Entering all the data', :js do
    visit root_path
    expect(page).to have_content 'Timesheet'
    fill_in_time_data
    click_on 'Save'
    expect(page).to have_content '3.50 km'
    expect(page).to have_content '20.00 min'
    expect{ TimeEntry.count == 1 }.to become_true
    time = TimeEntry.where(:date => '27/04/2014').first
    expect(time.distance).to eql 3.5 * 1000.0
    expect(time.time).to eql 20*60.0
    expect(time.user).to eql user
  end

  def fill_in_time_data
    fill_ng_datepicker('date', with: '27/04/2014')
    fill_in :distance, with: '3.5 km'
    fill_in :time, with: '20 min'
  end

  def fill_ng_datepicker id, options
    page.execute_script <<-JS
      var datePicker = $('##{ id }').data();
      datePicker.$ngModelController.$setViewValue('#{ options[:with] }');
    JS
  end
end
