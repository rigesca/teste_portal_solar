class PowerGeneratorsController < ApplicationController
  before_action :set_varibles, only: %i[show freight_calculate]

  def index
    @power_generators = PowerGenerator.order(:name).page(params[:page])
  end

  def show; end

  def simple_search
    if params[:q].present?
      @power_generators = PowerGeneratorSearch.simple_search(params[:q],
                                                             params[:order])
                                              .page(params[:page])
    end

    render :index
  end

  def advanced_search
    @power_generators = PowerGeneratorSearch.advanced_search(params)
                                            .page(params[:page])

    render :index
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
