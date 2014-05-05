FactoryGirl.define do
  factory :time_entry do
    date Date.today
    distance 1000
    time 100
    user
  end
end
