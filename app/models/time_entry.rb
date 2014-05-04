class TimeEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: DateTime
  field :time, type: Float
  field :distance, type: Float
  field :avg_speed, type: Float

  validates :date, presence: true
  validates :distance, presence: true, numericality: {
    greater_than: 0
  }
  validates :time, presence: true, numericality: {
    greater_than: 0
  }

  after_validation :calculate_avg_speed

  private

  def calculate_avg_speed
    self.avg_speed = distance.to_f/time
  end
end
