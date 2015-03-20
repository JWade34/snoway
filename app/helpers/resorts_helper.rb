module ResortsHelper

  def flights_for_resort(flights: resort:)
    flights.select do |flight|
      resort.cities.include? flight.destination
    end
  end
end
