class TimeEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date
  field :time, type: Integer
  field :distance, type: Integer
  field :avg_speed, type: Float

  validates :date, presence: true
  validates :time, presence: true

  after_validation :calculate_avg_speed

  private

  def calculate_avg_speed
    self.avg_speed = distance.to_f/time
  end
end
