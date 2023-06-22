class Rate < ApplicationRecord
  belongs_to :user
  attr_accessor :date

end
