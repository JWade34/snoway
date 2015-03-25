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
    elsif name.include?("QC")
      "Buffalo"
    elsif name.include?("WY")
      "Jackson Hole"
    elsif name.include?("MT")
      "Bozeman"
    elsif name.include?("AK")
      "Anchorage"
    elsif name.include?("BC")
      "Vancouver"
    elsif name.include?("NY")
      "Buffalo"
    elsif name.include?("ID")
      "Portland"
    elsif name.include?("OR")
      "Portland"
    elsif name.include?("NM") || name == "Durango Mountain Resort CO" || name == "Wolf Creek, CO"
      "Santa Fe"
    elsif name.include?("CO")
      "Denver"
    elsif name == "Bear Mountain"
      "Los Angles"
    elsif name.include?("CA")
      "San Francisco"
    elsif name.include?("WA") || name == "Whistler, BC"
      "Seattle"
    elsif name.include?("UT")
      "Salt Lake City"
    else
      "Grab a flight today"
    end
  end

  def max_temp
    max = hourly_forecasts.future.map do |forecast|
      forecast.temperature_max.to_f.round(0)
    end
  end

  def min_temp
    min = hourly_forecasts.future.map do |forecast|
      forecast.temperature_min.to_f.round(0)
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
