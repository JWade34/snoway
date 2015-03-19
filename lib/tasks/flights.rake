namespace :travel do

  desc "get flights to major cities near resorts"
  task :flights => :environment do

    require 'json'
    require 'http'

    api_key = ENV["GOOGLE_API_KEY"]

    origin = "IAH"
    destinations = %w( DEN SLC SFO SEA BTV )
    date = "2015-03-20"


    destinations.each do |destination|
      request = {"request"=>{"slice"=>[{:origin=>origin, :destination=>destination, :date=>date}], "passengers"=>{:adultCount=>1, :infantInLapCount=>0, :infantInSeatCount=>0, :childCount=>0, :seniorCount=>0}, "solutions"=>5, "refundable"=>false}}
      text = HTTP.with_headers(:accept => 'application/json').post("https://www.googleapis.com/qpxExpress/v1/trips/search?key=#{api_key}", json: request).to_s
      data = JSON.parse(text)

        flight = Flight.new
        flight.price = data["trips"]["tripOption"].first["saleTotal"]
        flight.carrier_code = data["trips"]["tripOption"].first["slice"].first["segment"].first["flight"]["carrier"]
        flight.flight_number = data["trips"]["tripOption"].first["slice"].first["segment"].first["flight"]["number"]
        flight.carrier_name = data["trips"]["data"]["carrier"].find {|h| h["code"] == flight.carrier_code}["name"]
        flight.destination = data["trips"]["data"]["city"].first["name"]
        flight.save

    end
  end
end
