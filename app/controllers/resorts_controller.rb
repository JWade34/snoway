class ResortsController < ApplicationController
  
  def index
    @resorts = Resort.all.sort_by(&:expected_snowfall).reverse
  end

  def show
    @resort = Resort.find params[:id]
  end


end
