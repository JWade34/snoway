class ResortsController < ApplicationController

  def index
    @flight = Flight.all
    date = Date.today + 1
    @day = date.strftime("%Y-%m-%d")

    week = Date.today + 7
    @add_week = week.strftime("%Y-%m-%d")


    if params[:search_text].present?
      @resorts = Resort.search(params[:search_text])
    else
      @resorts = Resort.all.sort_by(&:expected_snowfall).reverse.first(12)
    end
  end

  def show
    date = Date.today + 1
    @day = date.strftime("%Y-%m-%d")

    week = Date.today + 7
    @add_week = week.strftime("%Y-%m-%d")

    @resort = Resort.find params[:id]
    @flight = Flight.all
  end

  def flight
    date = Date.today + 1
    @day = date.strftime("%Y-%m-%d")

    week = Date.today + 7
    @add_week = week.strftime("%Y-%m-%d")

    @flight = Flight.all
  end


end
