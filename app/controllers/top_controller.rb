class TopController < ApplicationController
  def index
    @plans = Project.is_plan
    @initiates = Project.is_initiate
  end
end
