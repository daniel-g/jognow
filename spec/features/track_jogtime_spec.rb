require 'spec_helper'

feature 'Track jog time' do
  scenario 'Entering all the data' do
    Timecop.travel Time.new(2014, 04, 27) do
      visit times_path
      fill_in_time_data
      click_on 'Save'
    end
    expect(page).to have_content 'Jogging times'
    expect(page).to have_content '3.5 km'
    expect(page).to have_content '20 min'
    time = Times.where(date: '27/04/2014').first
    expect(time.distance).to eql '3500'
    expect(time.time).to eql '20'
  end

  def fill_in_time_data
    fill_in :distance, with: '3.5 km'
    fill_in :time, with: '20 min'
  end
end
