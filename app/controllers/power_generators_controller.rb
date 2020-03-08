class PowerGeneratorsController < ApplicationController
  before_action :set_varibles, only: %i[show freight_calculate]

  def index
    @power_generators = PowerGenerator.all
  end

  def show
  end

  def simple_search
    return if params[:q].blank?

    @power_generators = PowerGenerator.word_search(params[:q])

    render :index
  end

  def advanced_search
    #WIP
  end

  def freight_calculate
    unless params[:cep].blank?
      @address = Cep.find(params[:cep]) unless params[:cep].blank?
      @freights = Freight.where(state: @address[:state])
                         .weight_range(@power_generator.lowest_weight)
    end

    render :show
  end

  private

  def set_varibles
    @power_generator = PowerGenerator.find(params[:id])
    @address = nil
    @freights = nil
  end
end
