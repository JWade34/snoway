namespace :weather do

  desc "get snowfall forecast for all ski resorts"
  task :forecasts => :environment do

    require 'json'
    require 'http'

    api_key = ENV["FORECASTIO_API_KEY"]

    Resort.all.each do |resort|

      text = Http.get("https://api.forecast.io/forecast/#{api_key}/#{resort.lat},#{resort.lng}")
      data = JSON.parse(text)
      data["daily"]["data"].each do |node|

        forecast = HourlyForecast
                    .where(resort_id: resort.id)
                    .where(datetime: Time.at(node["time"]))
                    .first_or_create #http://apidock.com/rails/ActiveRecord/Relation/first_or_create
        forecast.temperature_min = node["temperatureMin"]
        forecast.temperature_max = node["temperatureMax"]
        forecast.precip_probability = node["precipProbability"]
        forecast.precip_accumulation = node["precipAccumulation"] || 0
        forecast.summary = node["summary"]
        forecast.precip_type = node["type"]
        forecast.save
      end
    end
  end
end
