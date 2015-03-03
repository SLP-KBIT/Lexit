class Project < ActiveRecord::Base
  belongs_to :user

  module Status
    Initiate = 0
    Plan = 1
  end

  def self.is_initiate
    return Project.where(status: Status::Initiate)
  end

  def self.is_plan
    return Project.where(status: Status::Plan)
  end
end
