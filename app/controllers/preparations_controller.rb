class PreparationsController < ApplicationController
  before_action :load_preparation

  def show
  end

  def update
    @preparation.update(update_params)
    redirect_to preparation_path(@preparation)
  end

  private

  def load_preparation
    @preparation = Preparation.find(params[:id]) unless params[:id].blank?
  end

  def preparation_params
    p = {}
    %w(book read note material).each do |key|
      p.store(key, params[key]) unless params[key].blank?
    end
    p
  end

  def update_params
    list = @preparation.prep_list
    list.each do |column, value|
      value.keys.each do |item|
        list[column][item] = !(preparation_params[column].nil? || preparation_params[column][item].nil?)
      end
    end
  end
end
