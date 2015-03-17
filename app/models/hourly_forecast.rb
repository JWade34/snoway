class HourlyForecast < ActiveRecord::Base
  belongs_to :resort

  scope :future, -> { where("datetime >= ?", Date.today)}
end
