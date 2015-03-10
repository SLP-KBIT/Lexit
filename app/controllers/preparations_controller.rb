class PreparationsController < ApplicationController
  before_action :load_preparation

  def show
  end

  private

  def load_preparation
    @preparation = Preparation.find(params[:id]) unless params[:id].blank?
  end
end
