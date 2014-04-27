class TimeEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date
  field :time, type: Integer
  field :distance, type: Integer

  validates :date, presence: true
  validates :time, presence: true
end
