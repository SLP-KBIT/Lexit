# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  isbn       :string(255)
#  name       :text
#  created_at :datetime
#  updated_at :datetime
#

class Book < ActiveRecord::Base
end
