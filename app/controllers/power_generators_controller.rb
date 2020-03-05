class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])
  end

  def search
    return if params[:q].blank?

    @power_generators = PowerGenerator.word_search("%#{params[:q]}%")

    render :index
  end
end
