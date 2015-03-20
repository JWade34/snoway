namespace :travel do

  desc "get flights to major cities near resorts"
  task :flights => :environment do

    require 'json'
    require 'http'

    api_key = ENV["GOOGLE_API_KEY"]

    origin = "IAH"
    destinations = %w( DEN SLC SFO SEA BTV )
    # destinations = Resort.all.map(&:airport_codes).flatten.uniq
    # destinations = %w(  BTV  )

    date = DateTime.tomorrow


    destinations.each do |destination|
      request = {"request"=>{"slice"=>[{:origin=>origin, :destination=>destination, :date=>date}], "passengers"=>{:adultCount=>1, :infantInLapCount=>0, :infantInSeatCount=>0, :childCount=>0, :seniorCount=>0}, "solutions"=>5, "refundable"=>false}}
      text = HTTP.with_headers(:accept => 'application/json').post("https://www.googleapis.com/qpxExpress/v1/trips/search?key=#{api_key}", json: request).to_s
      data = JSON.parse(text)

      carrier_code = data["trips"]["tripOption"].first["slice"].first["segment"].first["flight"]["carrier"]

      flight_number = data["trips"]["tripOption"].first["slice"].first["segment"].map{|k| k["flight"]}.map(&:values).flatten.join("-")
      # flight_number = data["trips"]["tripOption"].first["slice"].first["segment"].first["flight"]["number"]
      carrier_name  = data["trips"]["data"]["carrier"].find {|h| h["code"] == carrier_code}["name"]


      # puts "Found carrier_name#{carrier_name} flight_number #{flight_number} for destination #{destination}"


      flight = Flight.where(carrier_name: carrier_name)
                      .where(flight_number: flight_number)
                      .first_or_create
      flight.price = data["trips"]["tripOption"].first["saleTotal"].gsub("USD", "").to_f.round(2)
      flight.carrier_code  = carrier_code
      flight.flight_number = flight_number
      flight.carrier_name  = carrier_name
      destination_code     = data["trips"]["tripOption"].first["slice"].first["segment"].last["leg"].last["destination"]
      flight.destination   = data["trips"]["data"]["city"].find {|h| h["code"] == destination_code}["name"]

      flight.save!

    end
  end
end
