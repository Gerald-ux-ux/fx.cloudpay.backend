class Disbursment < ApplicationRecord
  belongs_to :user
  attr_accessor :formatted_date
    attribute :amount, :decimal

end
