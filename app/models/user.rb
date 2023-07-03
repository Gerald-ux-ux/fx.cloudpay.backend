class User < ApplicationRecord
  attribute :name, :string
  has_secure_password
  has_many :collections
  has_many :balances
  has_many :rates
  has_many :openings
  has_many :disbursments
  attr_accessor :formatted_date
end
