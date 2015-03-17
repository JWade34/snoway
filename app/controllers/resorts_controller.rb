class ResortsController < ApplicationController
  def index
    @resorts = Resort.all #.sort_by(weekly_snow)
    @resort = Resort.find params[:id]
  end

  def show
    @resort = Resort.find params[:id]
  end

  def weekly_snow
    total = @resort.hourly_forecasts.map do |forecast|
      forecast.precip_accumulation.to_f
    end
      total.sum.round(2)
  end

end
