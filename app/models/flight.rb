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
    elsif destination == "Salt Lake City"
      "SLC"
    elsif destination == "San Francisco"
      "SFO"
    elsif destination == "Seattle"
      "SEA"
    elsif destination == "Burlington"
      "BTV"
    elsif destination == "Santa Fe"
      "SAF"
    elsif destination == "Portland"
      "PDX"
    elsif destination == "Buffalo"
      "BUF"
    elsif destination == "Anchorage"
      "ANC"
    elsif destination == "Jackson Hole"
      "JAC"
    elsif destination == "Bozeman"
      "BZN"
    else
      ""
    end

  end

end
