class TopController < ApplicationController
  def index
    @plans = SeminarProject.is_plan.page(params[:plan_page]).per(10)
    @initiates = SeminarProject.is_initiate.page(params[:initiate_page]).per(10)
  end
end
