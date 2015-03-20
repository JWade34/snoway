class Resort < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader


  has_many :hourly_forecasts

  validates :name, :lat, :lng, presence: true

  before_validation on: :create do

    results = Geocoder.search(name)
    location = results.first.geometry["location"]
    self.lat = location["lat"]
    self.lng = location["lng"]

  end

  def cities
    if name.include?("VT")
      "Burlington"
    elsif name.include?("CO")
      "Denver"
    elsif name.include?("CA")
      "San Francisco"
    elsif name.include?("WA") || "Whistler, BC"
      "Seattle"
    else
      "Salt Lake City"
    end
  end

  def expected_snowfall
    accumulations = hourly_forecasts.future.map do |forecast|
      forecast.precip_accumulation.to_f
    end
    accumulations.sum.round(2)


    # hourly_forecasts
    #   .future
    #   .map(&:precip_accumulation)
    #   .map(&:to_f)
    #   .sum
    #   .round(2)
  end

  include PgSearch
  pg_search_scope :search,
                  :against => [:name],
                  :using => {
                    :tsearch => {
                      :dictionary => "english"}
                  }

end
