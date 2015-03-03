class TopController < ApplicationController
  def index
    @plans = SeminarProject.is_plan
    @initiates = SeminarProject.is_initiate
  end
end
