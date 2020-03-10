class FreightsController < ApplicationController
  def index
    @address = params[:address]
    @freights = Freight.where(state: @address[:state])
  end
end
