class Resort < ActiveRecord::Base

  has_many :hourly_forecasts

  validates :name, :lat, :lng, presence: true

  before_validation on: :create do

    results = Geocoder.search(name)
    location = results.first.geometry["location"]
    self.lat = location["lat"]
    self.lng = location["lng"]

  end

end
