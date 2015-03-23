class ResortsController < ApplicationController

  def index
    @flight = Flight.all

    if params[:search_text].present?
      @resorts = Resort.search(params[:search_text])
    else
      @resorts = Resort.all.sort_by(&:expected_snowfall).reverse
    end
  end

  def show
    @resort = Resort.find params[:id]
    @flight = Flight.all
  end

  def flight
    @flight = Flight.all
  end


end
