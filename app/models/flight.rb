class Flight < ActiveRecord::Base

  def resort
    if destination == "Denver"
      "Denver"
    elsif destination == "Salt Lake"
      "Park City"
    end
  end


  def airport
    if destination == "Denver"
      "DEN"
    else
      ""
    end

  end

end
